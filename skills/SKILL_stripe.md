# 💳 SKILL: Stripe Integration Patterns

## Setup Inicial

```typescript
// src/lib/stripe.ts
import Stripe from "stripe"

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: "2024-12-18.acacia",
  typescript: true,
})

// Helper: buscar ou criar customer
export async function getOrCreateStripeCustomer(user: {
  id: string
  email: string
  name?: string | null
  stripeCustomerId?: string | null
}): Promise<string> {
  if (user.stripeCustomerId) return user.stripeCustomerId

  const customer = await stripe.customers.create({
    email: user.email,
    name: user.name ?? undefined,
    metadata: { userId: user.id },
  })

  await db.user.update({
    where: { id: user.id },
    data: { stripeCustomerId: customer.id },
  })

  return customer.id
}
```

## Checkout Session

```typescript
// src/actions/billing/create-checkout.ts
"use server"

export async function createCheckoutSession(priceId: string) {
  const user = await getCurrentUser()
  if (!user) return { success: false, error: "Não autenticado" }

  const customerId = await getOrCreateStripeCustomer(user)

  const session = await stripe.checkout.sessions.create({
    customer: customerId,
    mode: "subscription",
    payment_method_types: ["card"],
    line_items: [{ price: priceId, quantity: 1 }],
    success_url: `${process.env.NEXTAUTH_URL}/billing?success=true`,
    cancel_url: `${process.env.NEXTAUTH_URL}/billing?canceled=true`,
    metadata: { userId: user.id },
    // Para Brasil: aceitar boleto
    payment_method_types: ["card", "boleto"],
    locale: "pt-BR",
  })

  redirect(session.url!)
}
```

## Webhook Handler

```typescript
// src/app/api/webhooks/stripe/route.ts
import { headers } from "next/headers"
import Stripe from "stripe"

export async function POST(req: Request) {
  const body = await req.text()
  const signature = headers().get("stripe-signature")!

  let event: Stripe.Event

  try {
    event = stripe.webhooks.constructEvent(
      body,
      signature,
      process.env.STRIPE_WEBHOOK_SECRET!
    )
  } catch {
    return new Response("Invalid signature", { status: 400 })
  }

  // Verificar idempotência
  const processed = await db.stripeEvent.findUnique({
    where: { stripeEventId: event.id }
  })
  if (processed) return new Response("Already processed", { status: 200 })

  // Processar evento
  switch (event.type) {
    case "checkout.session.completed":
      await handleCheckoutCompleted(event.data.object as Stripe.Checkout.Session)
      break
    case "customer.subscription.updated":
      await handleSubscriptionUpdated(event.data.object as Stripe.Subscription)
      break
    case "customer.subscription.deleted":
      await handleSubscriptionDeleted(event.data.object as Stripe.Subscription)
      break
    case "invoice.payment_succeeded":
      await handleInvoicePaid(event.data.object as Stripe.Invoice)
      break
    case "invoice.payment_failed":
      await handleInvoiceFailed(event.data.object as Stripe.Invoice)
      break
  }

  // Marcar como processado
  await db.stripeEvent.create({ data: { stripeEventId: event.id } })

  return new Response("OK", { status: 200 })
}
```

## Customer Portal

```typescript
export async function createBillingPortalSession() {
  const user = await getCurrentUser()
  if (!user?.stripeCustomerId) throw new Error("No Stripe customer")

  const session = await stripe.billingPortal.sessions.create({
    customer: user.stripeCustomerId,
    return_url: `${process.env.NEXTAUTH_URL}/billing`,
  })

  redirect(session.url)
}
```

## Teste Local de Webhooks

```bash
# Instalar Stripe CLI
brew install stripe/stripe-cli/stripe

# Login
stripe login

# Forward para local
stripe listen --forward-to localhost:3000/api/webhooks/stripe

# Testar evento específico
stripe trigger checkout.session.completed
```
