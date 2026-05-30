---
name: saas-orchestrator
description: Coordena a geração completa de aplicações SaaS em fases (foundation, auth, billing, core, deploy). Use quando o usuário pedir para iniciar um novo SaaS, executar o master orchestrator, ou seguir as fases do framework.
---

# SaaS Master Orchestrator

## Pré-requisitos

Antes de iniciar, confirme que existem:

- `templates/project_config.md` — stack e preferências (preenchido)
- `templates/business_context.md` — contexto de negócio (preenchido)

Se não estiverem preenchidos, peça ao usuário para completá-los ou use a skill `project-setup`.

## Instruções

1. Leia `orchestrators/MASTER_ORCHESTRATOR.md` e siga o fluxo completo.
2. As regras em `.cursor/rules/` já estão ativas — nunca viole `global.mdc` ou `security.mdc`.
3. Execute as fases **em ordem** (1 → 5). Nunca pule fases.
4. Ao iniciar, confirme entendimento com 5 bullets e peça aprovação das decisões técnicas.
5. Aguarde confirmação do usuário antes de cada fase subsequente.
6. Ao final de cada fase, liste o que foi gerado e o que vem a seguir.

## Formato do fluxo de fases

Ao mostrar a ordem das fases, use **tabela** ou **lista numerada**.

**Nunca** gere Mermaid inválido como:
```
Fase 1 (Foundation) → Fase 2 (Auth) → Fase 3 (Billing) ...
```

Isso causa `Mermaid Syntax Error`. Se precisar de diagrama, copie o bloco validado em `orchestrators/MASTER_ORCHESTRATOR.md`.

## Fases

| Fase | Skill | Orquestrador |
|------|-------|--------------|
| 1 — Foundation | `phase-1-foundation` | `orchestrators/PHASE_1_foundation.md` |
| 2 — Auth & Security | `phase-2-auth-security` | `orchestrators/PHASE_2_auth_security.md` |
| 3 — Billing | `phase-3-billing` | `orchestrators/PHASE_3_billing.md` |
| 4 — Core Features | — | `orchestrators/PHASE_4_core_features.md` (quando existir) |
| 5 — Deploy | — | `orchestrators/PHASE_5_deploy.md` (quando existir) |

## Formato de saída

Para cada arquivo gerado:

- Caminho completo: `src/lib/auth/session.ts`
- Código completo, sem truncar
- Marque com `[CONFIGURAR]` onde o dev precisa preencher valores
