# 🚀 PHASE 5 — Deploy & Observability Orchestrator

## Pré-requisitos

- Fases 1–4 concluídas ✅
- `npm run build` e `npm run test` passando localmente ✅
- `templates/project_config.md` com seção **Deploy e produção** preenchida ✅

---

## Prompt de Execução

```
Você é o DEVOPS_AGENT executando a FASE 5 do SaaS Framework.

## Contexto (fonte única — não pergunte no chat)

Leia `templates/project_config.md`:
- deploy_target: Vercel | VPS
- production_url, ci_cd
- Bloco vercel: ou vps: conforme o destino
- db_host_prod (Neon, Postgres no VPS, etc.)

Leia `references/deploy/PATTERNS.md` antes de gerar arquivos.

Resuma em 1 parágrafo qual destino está ativo e quais valores de [CONFIGURAR] faltam.

## Tarefa: Deploy & Observability

### PARTE 0 — Ramificação por deploy_target

| deploy_target | Executar | Não gerar |
|---------------|----------|-----------|
| **Vercel** | PARTE 2A + docs DEPLOY_VERCEL | Caddy, systemd, deploy-vps.sh, docker-compose.prod |
| **VPS** | PARTE 2B + docs DEPLOY_VPS + standalone | vercel.json (ou arquivo vazio com comentário "não usado") |

Se `deploy_target` inválido ou vazio, pare e peça para preencher o template.

---

### PARTE 1 — Comum (Vercel e VPS)

Gere ou atualize:

1. **CI/CD** — `.github/workflows/ci.yml`
   - Triggers: push/PR em `main`
   - Steps: checkout, Node 20, `npm ci`, `prisma generate`, lint, test, build
   - `DATABASE_URL` dummy no CI para build Prisma/Next

2. **Observability**
   - `src/lib/logger.ts` — logs JSON em `NODE_ENV=production`
   - `src/lib/env.ts` — validação Zod; falhar startup se env crítica ausente em produção
   - `src/instrumentation.ts` — hook de inicialização
   - `src/app/api/health/route.ts` — `status`, `version`, `environment`, `checks.database`

3. **Next.js**
   - Se VPS: `output: "standalone"` em `next.config.ts` / `next.config.mjs`
   - Se Vercel: standalone opcional; priorizar compatibilidade Vercel

4. **Checklist**
   - `docs/PRODUCTION_CHECKLIST.md` — pré/pós deploy (auth URLs, Stripe webhook, migrations, backups)

5. **Env de produção**
   - Atualizar `.env.example` com comentário: `NEXTAUTH_URL` = `production_url` do project_config

---

### PARTE 2A — Somente se deploy_target: Vercel

Gere:

- `vercel.json` — `regions: [vercel.region]` (ex. `gru1`); `buildCommand` com `prisma generate`
- `docs/DEPLOY_VERCEL.md` com:
  - Importar repo Git na Vercel
  - Tabela de variáveis (DATABASE_URL, AUTH_*, STRIPE_*, etc.)
  - Domínio customizado = `production_url`
  - Google OAuth redirect: `{production_url}/api/auth/callback/google`
  - Stripe webhook: `{production_url}/api/webhooks/stripe`
  - `prisma migrate deploy` (local ou workflow opcional)

Referência: `references/deploy/vercel.json.example`

---

### PARTE 2B — Somente se deploy_target: VPS

Gere:

- `docs/DEPLOY_VPS.md` com passo a passo:
  1. Provisionar VPS (Ubuntu LTS), usuário `vps.ssh_user`, firewall 22/80/443
  2. Node `vps.node_version`, clone em `vps.deploy_path`
  3. `.env` em produção (nunca no Git)
  4. `npm ci && prisma generate && prisma migrate deploy && npm run build`
  5. Rodar standalone: `node .next/standalone/server.js` na `vps.app_port`
  6. Proxy (`vps.reverse_proxy`): Caddy ou Nginx → HTTPS para `production_url`
  7. Process manager (`vps.process_manager`): systemd | PM2 | Docker
  8. DNS A/AAAA → `vps.host`
  9. Webhooks Stripe/OAuth com `production_url`

Artefatos conforme `vps.process_manager` e `vps.reverse_proxy`:

| Config | Arquivos |
|--------|----------|
| Caddy | `deploy/Caddyfile` (de `references/deploy/Caddyfile.example`) |
| Nginx | `deploy/nginx.conf` + instrução certbot |
| PM2 | `ecosystem.config.cjs` |
| systemd | `deploy/app.service` |
| Docker | `docker-compose.prod.yml` + `Dockerfile` multi-stage |

- `scripts/deploy-vps.sh` — build local ou no servidor, restart do serviço [CONFIGURAR SSH/host]

Se `vps.postgres_on_vps: true`, documentar Postgres no VPS + backup; senão usar `db_host_prod` remoto (Neon).

Referências: `references/deploy/Caddyfile.example`, `ecosystem.config.cjs.example`, `app.service.example`

---

### PARTE 3 — README do projeto

Atualizar README do SaaS: tabela de fases, link para `DEPLOY_VERCEL.md` ou `DEPLOY_VPS.md`.

## Formato de Entrega

Código completo, sem truncar. Marque [CONFIGURAR] onde o dev preenche IP, domínio, secrets.

Gere arquivos apenas no **projeto SaaS do usuário**, não no repo saas-ai-framework.
```

---

## ✅ Checklist de Conclusão

### Sempre

- [ ] `.github/workflows/ci.yml` criado
- [ ] Logger, env validation, `/api/health` funcionando
- [ ] `docs/PRODUCTION_CHECKLIST.md` criado
- [ ] `npm run build` e `npm run test` passando

### Se deploy_target: Vercel

- [ ] `vercel.json` com região do `project_config`
- [ ] `docs/DEPLOY_VERCEL.md` completo
- [ ] App deployado — URL pública = `production_url` [CONFIGURAR pelo dev]

### Se deploy_target: VPS

- [ ] `output: "standalone"` no Next config
- [ ] `docs/DEPLOY_VPS.md` + artefatos proxy/process manager
- [ ] `scripts/deploy-vps.sh` (ou workflow deploy SSH)
- [ ] App acessível em `production_url` [CONFIGURAR pelo dev]

---

## 📤 Output Esperado

```
# Comum
.github/workflows/ci.yml
src/lib/logger.ts
src/lib/env.ts
src/instrumentation.ts
src/app/api/health/route.ts
docs/PRODUCTION_CHECKLIST.md

# Vercel
vercel.json
docs/DEPLOY_VERCEL.md

# VPS
docs/DEPLOY_VPS.md
deploy/Caddyfile | deploy/nginx.conf
ecosystem.config.cjs | deploy/app.service | docker-compose.prod.yml
scripts/deploy-vps.sh
next.config (standalone)
```

---

## Próximo passo

Projeto em produção. Opcional: Sentry, uptime (UptimeRobot), backups automatizados no VPS.
