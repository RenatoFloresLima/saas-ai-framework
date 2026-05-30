---
name: phase-5-deploy
description: Executa a Fase 5 (Deploy) — Vercel ou VPS conforme project_config.md. CI/CD, health check e documentação de produção. Use após as fases 1–4 ou quando o usuário pedir deploy.
---

# Fase 5 — Deploy & Observability

## Instruções

1. Leia `templates/project_config.md` — `deploy_target` (Vercel | VPS), `production_url`, blocos `vercel:` ou `vps:`.
2. Leia `orchestrators/PHASE_5_deploy.md` e execute **apenas** o ramo do destino escolhido.
3. Leia `references/deploy/PATTERNS.md` e use exemplos em `references/deploy/`.
4. Siga `agents/DEVOPS_AGENT.md`.
5. Gere arquivos no **projeto SaaS do usuário**, não neste repositório do framework.

## Critério de conclusão

CI + health + docs do destino escolhido. URL pública em `production_url` é [CONFIGURAR] pelo dev (Vercel dashboard ou VPS).
