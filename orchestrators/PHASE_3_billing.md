# 💳 PHASE 3 — Billing & Plans Orchestrator

## Pré-requisitos
- Fase 1 e 2 concluídas ✅
- Conta Stripe criada com produtos e preços configurados ✅
- Variáveis `STRIPE_*` no `.env` ✅

---

## Prompt de Execução

```
Você é o BILLING_AGENT executando a FASE 3 do SaaS Framework.

## Contexto
Stack: [inserir de project_config.md]
Planos definidos: [inserir de business_context.md]
Prisma Schema atual: [colar schema atual]

## Tarefa: Sistema Completo de Billing

### PARTE 1 — Database Schema (Billing)

Adicione ao schema Prisma:

```prisma
model Plan {
  id          String   @id @default(cuid())
  name        String   // "Free", "Pro", "Enterprise"
  description String?
  price       Decimal  @db.Decimal(10,2)
  interval    BillingInterval // MONTHLY, YEARLY
  stripePriceId String? @unique
  features    Json     // { maxUsers: 5, maxProjects: 10, ... }
  isActive    Boolean  @default(true)
  order       Int      @default(0)
  
  subscriptions Subscription[]
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}

model Subscription {
  id                   String   @id @default(cuid())
  userId               String
  planId               String
  stripeSubscriptionId String?  @unique
  stripeCustomerId     String?
  status               SubscriptionStatus
  currentPeriodStart   DateTime
  currentPeriodEnd     DateTime
  cancelAtPeriodEnd    Boolean  @default(false)
  canceledAt           DateTime?
  
  user    User @relation(fields: [userId], references: [id], onDelete: Cascade)
  plan    Plan @relation(fields: [planId], references: [id])
  invoices Invoice[]
  
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Invoice {
  id             String   @id @default(cuid())
  subscriptionId String
  stripeInvoiceId String? @unique
  amount         Decimal  @db.Decimal(10,2)
  status         InvoiceStatus
  paidAt         DateTime?
  invoiceUrl     String?
  
  subscription Subscription @relation(fields: [subscriptionId], references: [id])
  createdAt    DateTime @default(now())
}

enum BillingInterval { MONTHLY YEARLY }
enum SubscriptionStatus { ACTIVE CANCELED PAST_DUE TRIALING INCOMPLETE }
enum InvoiceStatus { DRAFT OPEN PAID VOID UNCOLLECTIBLE }
```

### PARTE 2 — Stripe Client & Config

Gere:
- `src/lib/stripe.ts` → cliente Stripe + funções utilitárias
- `src/lib/billing/plans.ts` → definição dos planos + helpers
- `src/lib/billing/limits.ts` → verificação de limites por plano
- `src/lib/billing/feature-flags.ts` → feature flags por plano

### PARTE 3 — Billing Actions

Gere em `src/actions/billing/`:
- `create-checkout.ts` → criar sessão de checkout Stripe
- `create-portal.ts` → criar sessão do portal do cliente
- `cancel-subscription.ts` → cancelar assinatura
- `update-subscription.ts` → upgrade/downgrade de plano
- `get-subscription.ts` → buscar assinatura atual do usuário

### PARTE 4 — Webhook Handler

Gere `src/app/api/webhooks/stripe/route.ts`:
- Verificação de assinatura Stripe (OBRIGATÓRIO)
- Handlers para eventos:
  - `checkout.session.completed` → ativar assinatura
  - `customer.subscription.updated` → atualizar status
  - `customer.subscription.deleted` → cancelar
  - `invoice.payment_succeeded` → registrar pagamento
  - `invoice.payment_failed` → notificar usuário
- Idempotência (verificar se evento já foi processado)
- Log de todos os webhooks recebidos

### PARTE 5 — Feature Gate Middleware

Gere:
- `src/lib/billing/gate.ts` → verificar se usuário tem acesso a feature
- `src/components/billing/feature-gate.tsx` → componente que bloqueia/libera UI
- `src/hooks/use-subscription.ts` → hook para dados de assinatura

### PARTE 6 — Páginas de Billing

Gere em `src/app/(dashboard)/billing/`:
- `page.tsx` → painel de billing (plano atual, próxima cobrança, histórico)
- `upgrade/page.tsx` → página de pricing com comparativo de planos
- `src/components/billing/pricing-table.tsx` → tabela de planos
- `src/components/billing/subscription-card.tsx` → card do plano atual
- `src/components/billing/invoice-list.tsx` → lista de faturas
- `src/components/billing/upgrade-modal.tsx` → modal de upgrade

### PARTE 7 — Emails de Billing

Gere:
- `src/emails/billing/payment-succeeded.tsx`
- `src/emails/billing/payment-failed.tsx`
- `src/emails/billing/subscription-canceled.tsx`
- `src/emails/billing/trial-ending.tsx`
- `src/emails/billing/upgrade-confirmation.tsx`

### PARTE 8 — Seed de Planos

Gere `prisma/seeds/plans.ts`:
```
Free: R$0/mês — 1 usuário, 3 projetos, sem suporte
Pro: R$49/mês — 5 usuários, projetos ilimitados, suporte email
Enterprise: R$199/mês — usuários ilimitados, tudo, suporte prioritário
```
(adapte conforme business_context.md)

## Regras de Billing Obrigatórias
- NUNCA processar pagamento sem verificar webhook signature
- SEMPRE usar idempotency keys no Stripe
- SEMPRE gravar stripeCustomerId no usuário na primeira assinatura
- Verificar limites do plano em TODAS as ações que consomem recursos
- Portal do cliente: usar sempre Stripe Customer Portal (não construir do zero)
```

---

## ✅ Checklist de Conclusão da Fase 3

- [ ] Planos seedados no banco
- [ ] Pricing page renderizando corretamente
- [ ] Checkout Stripe abrindo (modo teste)
- [ ] Após pagamento, assinatura ativa no banco
- [ ] Webhook recebendo e processando eventos
- [ ] Portal do cliente abrindo
- [ ] Feature gate bloqueando recursos por plano
- [ ] Emails de billing sendo enviados
- [ ] Cancelamento funciona e reflete no status
