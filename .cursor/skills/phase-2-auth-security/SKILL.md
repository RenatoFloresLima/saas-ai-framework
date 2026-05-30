---
name: phase-2-auth-security
description: Executa a Fase 2 (Auth & Security) — login, OAuth, RBAC, middlewares e páginas de auth. Use após a Fase 1 estar concluída ou quando o usuário pedir autenticação e segurança.
---

# Fase 2 — Auth & Security

## Instruções

1. Leia `orchestrators/PHASE_2_auth_security.md` e execute todas as etapas.
2. Coordene os agents:
   - `agents/AUTH_AGENT.md` — autenticação
   - `agents/SECURITY_AGENT.md` — RBAC e middlewares
   - `agents/DATABASE_AGENT.md` — schema de usuários e sessões
3. A Fase 1 deve estar concluída (schema base existente).

## Critério de conclusão

Usuário consegue registrar, logar, logout. RBAC funcionando.

## Próximo passo

Após confirmação, avance para a skill `phase-3-billing`.
