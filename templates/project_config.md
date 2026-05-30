# 📐 TEMPLATE: project_config.md

> Preencha este arquivo antes de usar o MASTER_ORCHESTRATOR.
> Quanto mais detalhe você fornecer, melhor o código gerado.

---

## Identificação do Projeto

```
Nome do projeto: [ex: Flowdesk, Gestora, ClienteHub]
Nome técnico (slug): [ex: flowdesk, gestora, clientehub]
Domínio principal: [ex: app.meudominio.com.br]
Idioma da UI: [Português Brasileiro]
Timezone padrão: [America/Sao_Paulo]
Moeda padrão: [BRL]
```

---

## Stack Técnica

### Obrigatório preencher:

```yaml
# Frontend
framework_frontend: Next.js 14 (App Router)  # ou: Nuxt 3, SvelteKit, Remix
ui_library: Tailwind CSS + shadcn/ui           # ou: Chakra UI, MUI
icons: Lucide React                            # ou: Heroicons, Radix Icons

# Backend
api_style: Next.js Server Actions + API Routes # ou: tRPC, REST puro, GraphQL

# Banco de Dados
database: PostgreSQL                           # ou: MySQL, SQLite (dev only)
orm: Prisma                                    # ou: Drizzle
db_host_dev: Docker local                      # ou: Supabase, Neon
db_host_prod: Neon                             # ou: Supabase, PlanetScale, Railway

# Autenticação
auth_library: NextAuth.js v5                   # ou: Clerk, Supabase Auth, Lucia
auth_providers:                                # listar os que precisa
  - credentials (email + senha)
  - google
  # - github
  # - magic-link

# Pagamentos
payment_provider: Stripe                       # ou: Mercado Pago (Brasil), Hotmart
payment_currency: BRL

# Email
email_provider: Resend                         # ou: SendGrid, Nodemailer
email_templates: React Email

# Storage (uploads de arquivos)
storage_provider: Cloudflare R2                # ou: AWS S3, Supabase Storage, UploadThing

# Deploy
deploy_target: Vercel                          # ou: Railway, Fly.io, Render
ci_cd: GitHub Actions

# Cache/Sessões (opcional)
cache: Redis via Upstash                       # ou: sem cache, Vercel KV
```

---

## Funcionalidades Base

Marque o que deve ser gerado:

```yaml
# Autenticação
feat_email_password: true
feat_oauth_google: true
feat_oauth_github: false
feat_magic_link: false
feat_2fa: true
feat_email_verification: true
feat_password_reset: true

# Multi-tenancy
feat_organizations: true          # workspace/organização
feat_member_invites: true         # convidar membros por email
feat_multi_role: true             # OWNER, ADMIN, MEMBER, VIEWER

# Billing
feat_billing: true
feat_free_plan: true              # plano gratuito
feat_paid_plans: true
feat_annual_discount: true        # desconto plano anual
feat_trial: false                 # período de trial gratuito
feat_trial_days: 0                # quantos dias de trial

# Perfil
feat_user_profile: true
feat_avatar_upload: true
feat_account_deletion: true       # GDPR compliance

# Notificações
feat_email_notifications: true
feat_in_app_notifications: false  # sino de notificações no app
feat_push_notifications: false

# Outros
feat_dark_mode: true
feat_i18n: false                  # internacionalização
feat_api_keys: false              # API keys para integração
feat_webhooks_outgoing: false     # webhooks para clientes
feat_audit_log: true
feat_analytics_dashboard: true   # métricas básicas no dashboard
```

---

## Planos e Preços

```yaml
plans:
  - name: Free
    price_monthly: 0
    price_yearly: 0
    stripe_price_id_monthly: ""     # preencher após criar no Stripe
    stripe_price_id_yearly: ""
    limits:
      max_users: 1
      max_projects: 3              # adaptar para sua entidade principal
      max_storage_mb: 100
      api_access: false
    
  - name: Pro
    price_monthly: 4900            # centavos: 4900 = R$49,00
    price_yearly: 47040            # R$470,40/ano (20% desc)
    stripe_price_id_monthly: ""
    stripe_price_id_yearly: ""
    limits:
      max_users: 10
      max_projects: -1             # -1 = ilimitado
      max_storage_mb: 10000
      api_access: true

  - name: Enterprise
    price_monthly: 19900           # R$199,00
    price_yearly: 191040
    stripe_price_id_monthly: ""
    stripe_price_id_yearly: ""
    limits:
      max_users: -1
      max_projects: -1
      max_storage_mb: -1
      api_access: true
```

---

## Configurações Visuais

```yaml
# Cores da marca (usar no tailwind.config.ts)
brand_primary: "#6366f1"          # indigo-500 (trocar pela sua cor)
brand_primary_dark: "#4f46e5"
brand_accent: "#f59e0b"

# Logo
logo_text: "NomeDoProjeto"        # ou caminho para SVG
logo_icon: "⚡"                   # emoji, ou deixar vazio se usar SVG

# Layout do Dashboard
dashboard_layout: sidebar          # sidebar | topnav
sidebar_position: left             # left | right (se sidebar)
```

---

## Variáveis de Ambiente Obrigatórias

> Complete após criar as contas nos serviços:

```bash
# Database
DATABASE_URL=                      # URL do PostgreSQL

# Auth
NEXTAUTH_SECRET=                   # openssl rand -base64 32
NEXTAUTH_URL=                      # http://localhost:3000

# OAuth
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# Stripe
STRIPE_SECRET_KEY=
STRIPE_PUBLISHABLE_KEY=
STRIPE_WEBHOOK_SECRET=

# Resend (email)
RESEND_API_KEY=
EMAIL_FROM=noreply@seudominio.com.br

# Cloudflare R2 (storage)
R2_ACCOUNT_ID=
R2_ACCESS_KEY_ID=
R2_SECRET_ACCESS_KEY=
R2_BUCKET_NAME=
R2_PUBLIC_URL=
```
