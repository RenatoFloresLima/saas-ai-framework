# Referência — Deploy (Vercel ou VPS)

Copiar/adaptar no **projeto SaaS do usuário** conforme `deploy_target` em `templates/project_config.md`.

| Arquivo | Quando |
|---------|--------|
| `PATTERNS.md` | Regras gerais Fase 5 |
| `vercel.json.example` | `deploy_target: Vercel` |
| `Caddyfile.example` | `deploy_target: VPS` + `reverse_proxy: Caddy` |
| `ecosystem.config.cjs.example` | VPS + `process_manager: PM2` |
| `app.service.example` | VPS + `process_manager: systemd` |
