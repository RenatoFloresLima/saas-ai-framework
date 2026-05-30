# 🏗 PHASE 1 — Foundation Orchestrator

## Objetivo
Criar a base técnica do projeto: estrutura de arquivos, configurações, banco de dados inicial e ambiente de desenvolvimento funcional.

---

## Prompt de Execução

```
Você é o ARCHITECT_AGENT executando a FASE 1 do SaaS Framework.

## Stack do Projeto
[INSERIR stack de project_config.md]

## Tarefa: Gerar a Fundação do Projeto

Execute em ordem:

### 1. Estrutura de Pastas
Gere a estrutura completa de diretórios do projeto com comentário explicando o propósito de cada pasta principal.

### 2. package.json
Gere o package.json completo com:
- Todas as dependências de produção necessárias (com versões)
- Todas as devDependencies
- Scripts: dev, build, start, lint, test, db:migrate, db:seed, db:studio

### 3. Arquivos de Configuração
Gere todos os arquivos de config:
- `tsconfig.json` (strict mode habilitado)
- `.eslintrc.json` (com regras para Next.js + TypeScript)
- `.prettierrc`
- `next.config.ts`
- `tailwind.config.ts`
- `components.json` (shadcn/ui)

### 4. Variáveis de Ambiente
Gere `.env.example` com TODAS as variáveis necessárias para todo o projeto (auth, db, stripe, email, etc.), com comentários explicando cada uma.

Auth (mínimo para SaaS default):
- `AUTH_SECRET`, `AUTH_URL`, `NEXTAUTH_URL`
- `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` (comentário: redirect `{AUTH_URL}/api/auth/callback/google`)

### 5. Docker Compose
Gere `docker-compose.yml` para desenvolvimento local com:
- PostgreSQL com dados persistentes
- Redis (para sessões/cache se aplicável)
- pgAdmin opcional

### 6. Prisma Schema Base
Gere `prisma/schema.prisma` com:
- Provider e datasource configurados
- Generators (client + opcional: zod)
- Modelos base: User, Session, Account (NextAuth pattern)
- Enums: Role (OWNER, ADMIN, MEMBER, VIEWER)
- Campos de auditoria em todos os modelos (createdAt, updatedAt, deletedAt)

### 7. Arquivos de Setup
Gere:
- `src/lib/db.ts` → cliente Prisma singleton
- `src/lib/utils.ts` → utilitários comuns (cn, formatDate, formatCurrency, etc.)
- `src/types/index.ts` → tipos TypeScript globais
- `src/middleware.ts` → middleware Next.js base

### 8. README do Projeto
Gere `README.md` com:
- Como rodar localmente
- Variáveis obrigatórias
- Comandos disponíveis
- Estrutura do projeto

## Formato de Entrega
Para cada arquivo:
1. Mostre o caminho: `path/to/file.ts`
2. Código completo (sem truncar)
3. Marque com [TODO] onde o dev deve personalizar

Ao final, mostre um checklist do que foi gerado.
```

---

## ✅ Checklist de Conclusão da Fase 1

Antes de avançar para a Fase 2, confirme:

- [ ] Estrutura de pastas criada
- [ ] `npm install` roda sem erros
- [ ] `npm run dev` inicia sem erros
- [ ] Docker Compose sobe o banco de dados
- [ ] `npx prisma migrate dev` cria as tabelas
- [ ] `npx prisma studio` abre e mostra as tabelas
- [ ] Linter não retorna erros
- [ ] `.env.example` tem todas as variáveis documentadas

---

## 📤 Output Esperado

```
project-root/
├── src/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   └── globals.css
│   ├── components/
│   │   └── ui/          ← shadcn components
│   ├── lib/
│   │   ├── db.ts
│   │   └── utils.ts
│   ├── types/
│   │   └── index.ts
│   └── middleware.ts
├── prisma/
│   ├── schema.prisma
│   ├── migrations/
│   └── seed.ts
├── docker-compose.yml
├── .env.example
├── package.json
├── tsconfig.json
├── tailwind.config.ts
└── README.md
```
