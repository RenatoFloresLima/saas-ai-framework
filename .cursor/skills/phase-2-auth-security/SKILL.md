---
name: phase-2-auth-security
description: Executa a Fase 2 (Auth & Security) — login, OAuth, RBAC, middlewares e páginas de auth. Use após a Fase 1 estar concluída ou quando o usuário pedir autenticação e segurança.
---

# Fase 2 — Auth & Security

## Instruções

1. Leia `orchestrators/PHASE_2_auth_security.md` e execute todas as etapas.
2. Leia e aplique `references/auth/PATTERNS.md` — copie/adapte arquivos de `references/auth/` no **projeto SaaS do usuário**, não neste repositório do framework.
3. Coordene os agents:
   - `agents/AUTH_AGENT.md` — autenticação
   - `agents/SECURITY_AGENT.md` — RBAC e middlewares
   - `agents/DATABASE_AGENT.md` — schema de usuários e sessões
4. A Fase 1 deve estar concluída (schema base existente).

## Critério de conclusão

Usuário consegue registrar, logar e **sair** (botão visível no header e sidebar). RBAC funcionando. Senha com toggle mostrar/ocultar. Google OAuth (se configurado) permite escolher conta.

## Próximo passo

Após confirmação, avance para a skill `phase-3-billing`.
