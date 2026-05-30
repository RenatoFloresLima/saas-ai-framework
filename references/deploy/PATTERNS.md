# Padrões — Fase 5 Deploy

## Decisão (project_config.md)

```yaml
deploy_target: Vercel   # ou VPS
production_url: https://app.exemplo.com.br
```

- **Vercel:** gere `vercel.json`, `docs/DEPLOY_VERCEL.md`; não gere Caddy/systemd no VPS.
- **VPS:** gere `docs/DEPLOY_VPS.md`, proxy, process manager, `output: "standalone"` no Next; não gere `vercel.json`.

## Variáveis de produção (ambos)

| Variável | Valor |
|----------|--------|
| `NEXTAUTH_URL` | `production_url` |
| `NEXT_PUBLIC_APP_URL` | `production_url` |
| `DATABASE_URL` | Neon ou Postgres (ver `db_host_prod`) |

## Next.js standalone (obrigatório para VPS)

```typescript
// next.config.ts
const nextConfig = {
  output: "standalone",
}
```

## Health check

`GET /api/health` → `{ status, version, environment, checks: { database } }`

## CI

`.github/workflows/ci.yml` — sempre, independente do deploy target.
