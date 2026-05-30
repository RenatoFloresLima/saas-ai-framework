# SaaS AI Framework

Framework de prompts, agents e regras para gerar **aplicações SaaS prontas para produção** com IA (Cursor, Claude, GPT-4).

A ideia: **gerar tudo que é padrão → você desenvolve só o diferencial do negócio.**

---

## O que este repositório contém

| Pasta | Função |
|-------|--------|
| `.cursor/rules/` | Regras aplicadas automaticamente pelo Cursor |
| `.cursor/skills/` | Skills invocáveis no chat (`saas-orchestrator`, `auth-agent`, etc.) |
| `orchestrators/` | Fases de geração (foundation → auth → billing → …) |
| `agents/` | Prompts especializados (auth, billing, frontend, …) |
| `subagents/` | Tarefas pontuais (CRUD, RBAC, …) |
| `rules/` | Fonte das regras (TypeScript, segurança, API, banco) |
| `templates/` | Config do projeto e contexto de negócio |

---

## Usar em outro projeto

Escolha **uma** das opções abaixo.

### Opção 1 — Script de instalação (recomendado)

Clone este repositório e rode o script apontando para o seu projeto:

```bash
git clone https://github.com/RenatoFloresLima/saas-ai-framework.git
cd saas-ai-framework

# Instalar em pasta vazia (novo SaaS)
./scripts/install-in-project.sh ~/projetos/meu-saas

# Ou instalar no diretório atual
./scripts/install-in-project.sh .
```

O script copia `.cursor/`, `agents/`, `orchestrators/`, `templates/` e demais pastas necessárias para o projeto destino.

### Opção 2 — Git submodule

Mantenha o framework como submodule e instale no projeto:

```bash
cd ~/projetos/meu-saas
git submodule add https://github.com/RenatoFloresLima/saas-ai-framework.git saas-ai-framework
./saas-ai-framework/scripts/install-in-project.sh .
```

Atualizar o framework depois:

```bash
git submodule update --remote saas-ai-framework
./saas-ai-framework/scripts/install-in-project.sh .
```

### Opção 3 — Copiar manualmente

Copie estas pastas/arquivos para a raiz do seu projeto:

```
.cursor/
agents/
orchestrators/
subagents/
rules/
skills/
templates/
AGENTS.md
```

---

## Fluxo de uso no Cursor

### 1. Configure o projeto

Preencha os templates com as informações do **seu** SaaS:

- `templates/project_config.md` — stack, domínio, auth, pagamentos
- `templates/business_context.md` — negócio, entidades, planos

Se preferir ajuda para preencher:

```
Use a skill project-setup
```

### 2. Inicie o orquestrador

Abra o projeto no Cursor e diga no chat:

```
Use a skill saas-orchestrator
```

O agent vai:

1. Resumir o projeto em 5 bullets
2. Listar decisões técnicas e pedir aprovação
3. Executar a **Fase 1** (foundation)
4. Aguardar sua confirmação antes de cada fase seguinte

### 3. Avance fase a fase

| Fase | Skill | Resultado |
|------|-------|-----------|
| 1 | `phase-1-foundation` | Estrutura, configs, Docker, Prisma base |
| 2 | `phase-2-auth-security` | Login, OAuth, RBAC, páginas de auth |
| 3 | `phase-3-billing` | Stripe, planos, checkout, webhooks |
| 4 | — | Dashboard, workspace, perfil (ver `orchestrators/`) |
| 5 | — | Deploy, CI/CD (ver `orchestrators/`) |

**Não pule fases.** Cada uma depende da anterior.

### 4. Expanda com agents individuais

Depois do setup inicial:

```
Use a skill crud-generator para a entidade Invoice com campos: ...
```

```
Use a skill auth-agent para adicionar login com GitHub OAuth
```

```
Use a skill billing-agent para criar plano Starter entre Free e Pro
```

---

## O que o Cursor carrega sozinho

As **rules** em `.cursor/rules/` entram automaticamente:

| Rule | Quando |
|------|--------|
| `global.mdc` | Sempre — TypeScript, nomenclatura, estrutura |
| `security.mdc` | Sempre — regras de segurança invioláveis |
| `api-design.mdc` | Ao editar `**/api/**` ou `**/actions/**` |
| `database.mdc` | Ao editar `**/prisma/**` |

As **skills** são invocadas explicitamente no chat (veja lista completa em [AGENTS.md](AGENTS.md)).

---

## Stack padrão

| Camada | Padrão | Alternativas |
|--------|--------|--------------|
| Frontend | Next.js 14 (App Router) | Nuxt, SvelteKit |
| UI | Tailwind + shadcn/ui | Chakra, MUI |
| Backend | Next.js Server Actions + API Routes | Express, tRPC |
| Banco | PostgreSQL + Prisma | MySQL, Supabase |
| Auth | NextAuth.js v5 | Clerk, Supabase Auth |
| Pagamentos | Stripe | Mercado Pago |
| Deploy | Vercel + Neon | Railway, Fly.io |

Defina alternativas em `templates/project_config.md`.

---

## Publicar este repositório no GitHub

Se você clonou localmente e ainda não publicou:

```bash
cd saas-ai-framework
git init
git add .
git commit -m "feat: SaaS AI Framework com orquestrador para Cursor"

# Autentique no GitHub (uma vez)
gh auth login

# Crie o repositório e envie
gh repo create saas-ai-framework --public --source=. --remote=origin --push
```

Ou crie o repositório manualmente em [github.com/new](https://github.com/new) e:

```bash
git remote add origin https://github.com/RenatoFloresLima/saas-ai-framework.git
git branch -M main
git push -u origin main
```

Depois de publicar, use a URL: https://github.com/RenatoFloresLima/saas-ai-framework

---

## Estrutura completa

```
saas-ai-framework/
├── README.md                 ← este arquivo
├── AGENTS.md                 ← mapa de skills e rules para Cursor
├── .cursor/
│   ├── rules/                ← regras automáticas (.mdc)
│   └── skills/               ← skills invocáveis
├── orchestrators/            ← MASTER_ORCHESTRATOR + fases
├── agents/                   ← agents especializados
├── subagents/                ← CRUD, RBAC, etc.
├── rules/                    ← fonte das rules
├── skills/                   ← padrões de stack (Stripe, etc.)
├── templates/                ← config e contexto de negócio
├── scripts/
│   └── install-in-project.sh ← instala o framework em outro projeto
└── docs/
    └── HOW_TO_USE.md         ← guia detalhado
```

---

## Documentação adicional

- [AGENTS.md](AGENTS.md) — referência rápida de skills e rules
- [docs/HOW_TO_USE.md](docs/HOW_TO_USE.md) — guia completo, dicas de prompting, troubleshooting

---

## Licença

MIT — use livremente em projetos pessoais e comerciais.
