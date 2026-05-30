---
name: phase-3-billing
description: Executa a Fase 3 (Billing) — Stripe, planos, checkout, webhooks e feature flags por plano. Use após Auth estar pronto ou quando o usuário pedir pagamentos e assinaturas.
---

# Fase 3 — Billing & Plans

## Instruções

1. Leia `orchestrators/PHASE_3_billing.md` e execute todas as etapas.
2. Atue como `BILLING_AGENT` — leia `agents/BILLING_AGENT.md`.
3. Use padrões Stripe da skill `stripe`.
4. Auth (Fase 2) deve estar concluída — billing depende de usuários autenticados.

## Critério de conclusão

Usuário consegue assinar um plano e ser cobrado via Stripe.

## Próximo passo

Após confirmação, avance para Fase 4 (core features) conforme `orchestrators/MASTER_ORCHESTRATOR.md`.
