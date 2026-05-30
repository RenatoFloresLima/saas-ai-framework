---
name: stripe
description: Padrões de integração Stripe — checkout, webhooks, customer portal e idempotência. Use quando implementar pagamentos Stripe, webhooks ou billing portal.
---

# Stripe Integration

Leia e siga os padrões em `skills/SKILL_stripe.md`.

## Checklist obrigatório

- [ ] Verificar assinatura do webhook (`constructEvent`)
- [ ] Idempotência — não processar o mesmo evento duas vezes
- [ ] `getOrCreateStripeCustomer` antes de checkout
- [ ] Nunca logar dados de cartão ou tokens
- [ ] Usar `Decimal` no Prisma para valores monetários

## Referência rápida

Arquivo fonte: `skills/SKILL_stripe.md`
