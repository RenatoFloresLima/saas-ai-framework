---
name: phase-2-auth-security
description: Executa a Fase 2 (Auth & Security) — login, OAuth, RBAC, middlewares e páginas de auth. Use após a Fase 1 estar concluída ou quando o usuário pedir autenticação e segurança.
---

# Fase 2 — Auth & Security

## Instruções

1. Leia `templates/project_config.md` (`auth_providers` + variáveis OAuth) — **fonte única**; não repita essas perguntas no chat.
2. Leia `orchestrators/PHASE_2_auth_security.md` e execute todas as etapas (inclui PARTE 0 — decisão OAuth pelo arquivo).
3. Leia e aplique `references/auth/PATTERNS.md` — copie/adapte arquivos de `references/auth/` no **projeto SaaS do usuário**, não neste repositório do framework.
4. Coordene os agents:
   - `agents/AUTH_AGENT.md` — autenticação
   - `agents/SECURITY_AGENT.md` — RBAC e middlewares
   - `agents/DATABASE_AGENT.md` — schema de usuários e sessões
5. A Fase 1 deve estar concluída (schema base existente).

## Critério de conclusão

Credenciais + email/senha + logout sempre. OAuth no checklist **somente** se credenciais já estiverem em `project_config.md`; se vazias, fase conclui com OAuth adiado (sem botão Google na UI).

## Próximo passo

Após confirmação, avance para a skill `phase-3-billing`.
