# 🔐 PHASE 2 — Auth & Security Orchestrator

## Pré-requisitos
- Fase 1 concluída ✅
- Schema base do Prisma criado ✅
- Variáveis de ambiente configuradas ✅

---

## Prompt de Execução

```
Você é o AUTH_AGENT + SECURITY_AGENT executando a FASE 2 do SaaS Framework.

## Contexto
Stack: [inserir de project_config.md]
Prisma Schema atual: [colar schema atual]

## Tarefa: Sistema Completo de Auth & Segurança

### PARTE 1 — Database Schema (Auth)

Expanda o schema Prisma adicionando:
- `VerificationToken` (email verification)
- `PasswordResetToken` (password reset)
- `TwoFactorSecret` (2FA TOTP)
- `TwoFactorConfirmation`
- `AuditLog` (registro de ações sensíveis)
- Adicione `emailVerified`, `twoFactorEnabled`, `image` ao modelo User

### PARTE 2 — NextAuth.js v5 Configuration

**Leia antes:** `references/auth/PATTERNS.md` e copie/adapte os arquivos de `references/auth/` para o projeto do usuário.

Gere:
- `src/auth.ts` → configuração principal do NextAuth
  - Providers: Credentials, Google (e GitHub se configurado em `project_config.md`)
  - Google: `authorization.params.prompt: "select_account"`; registrar provider só se `GOOGLE_CLIENT_ID` e `GOOGLE_CLIENT_SECRET` existirem
  - Callbacks: session, jwt, signIn
  - Adapter Prisma
  - `pages.error: "/login"` em `auth.config.ts`
- `src/auth.config.ts` → config sem adapter (para Edge)
- `src/middleware.ts` → proteção de rotas (atualizado)
- `src/lib/auth/session.ts` → helpers de sessão no server

### PARTE 3 — Auth Actions (Server Actions)

Gere em `src/actions/auth/`:
- `login.ts` → login com email/senha + 2FA check
- `register.ts` → registro + envio de email de verificação
- `logout.ts` → logout seguro
- `forgot-password.ts` → envio de reset link
- `reset-password.ts` → redefinição de senha
- `verify-email.ts` → verificação de email por token
- `toggle-2fa.ts` → ativar/desativar 2FA

Cada action deve:
- Usar Zod para validação de input
- Retornar `{ success, error, data }` padronizado
- Logar ações sensíveis no AuditLog

### PARTE 4 — RBAC (Role-Based Access Control)

Gere:
- `src/lib/auth/rbac.ts` → definição de permissões por role
- `src/lib/auth/permissions.ts` → check de permissão
- `src/middleware/with-auth.ts` → HOC server-side
- `src/hooks/use-current-user.ts` → hook client-side
- `src/hooks/use-current-role.ts` → hook client-side

Mapa de permissões padrão:
```typescript
OWNER: tudo
ADMIN: gerenciar membros, recursos da org
MEMBER: criar/editar recursos próprios
VIEWER: somente leitura
```

### PARTE 5 — Páginas de Autenticação

Gere em `src/app/(auth)/`:
- `login/page.tsx` + `LoginForm` component
  - `googleOAuthEnabled={isGoogleOAuthEnabled()}` na page (server)
  - `PasswordInput` para senha; exibir erros OAuth (`getOAuthErrorMessage`)
- `register/page.tsx` + `RegisterForm` component
  - Mesmo padrão: `PasswordInput`, botão Google condicional
- `forgot-password/page.tsx`
- `reset-password/page.tsx` → `PasswordInput` nos campos de senha
- `verify-email/page.tsx`
- `two-factor/page.tsx`
- `layout.tsx` → layout compartilhado das páginas auth

Gere também:
- `src/components/ui/password-input.tsx` (ver `references/auth/password-input.tsx`)
- `src/lib/auth/oauth.ts` (ver `references/auth/oauth.ts`)
- `src/components/providers/session-provider.tsx` — layout raiz passa `session={await auth()}`

Padrão visual: Card centralizado, logo, formulário com React Hook Form + Zod

### PARTE 5b — Dashboard: logout e sessão

No projeto gerado (layout do dashboard):
- `src/app/(dashboard)/layout.tsx` (async): `DashboardUserMenu` com `getCurrentUser()` — ver `references/auth/dashboard-user-menu.tsx`
- Sidebar: item **Sair** com `<form action={logoutAction}>`
- Não depender só de `useSession()` no header para exibir logout

### PARTE 6 — Segurança

Gere:
- `src/middleware/rate-limit.ts` → rate limiting por IP e por usuário
- `src/lib/security/csrf.ts` → proteção CSRF
- `src/lib/security/headers.ts` → security headers (CSP, HSTS, etc.)
- Adicione headers de segurança no `next.config.ts`
- `src/lib/security/sanitize.ts` → sanitização de inputs

### PARTE 7 — Email Templates

Gere com Resend + React Email:
- `src/emails/verify-email.tsx`
- `src/emails/reset-password.tsx`
- `src/emails/welcome.tsx`
- `src/lib/email.ts` → função de envio centralizada

## Regras de Segurança Obrigatórias
- Senhas: bcrypt com salt rounds >= 12
- Tokens: crypto.randomBytes(32) em hex
- Tokens têm expiração (verify: 1h, reset: 30min)
- Nunca expor hash de senha em responses
- Sempre validar ownership antes de operações
- Rate limit em todas as rotas de auth (5 tentativas / 15 min)
- Log de todas as tentativas de login (sucesso e falha)
```

---

## ✅ Checklist de Conclusão da Fase 2

- [ ] `npx prisma migrate dev` roda sem erros
- [ ] Registro de usuário funciona + email de verificação enviado
- [ ] Login com credenciais funciona
- [ ] Login com Google/GitHub funciona (seleção de conta Google; redirect URI correta)
- [ ] Campos de senha têm toggle mostrar/ocultar (`PasswordInput`)
- [ ] Botão "Sair" visível no header e na sidebar após login
- [ ] Logout funciona e limpa sessão
- [ ] Erros OAuth exibem mensagem clara na página de login
- [ ] Reset de senha funciona end-to-end
- [ ] Rotas protegidas redirecionam para login
- [ ] RBAC bloqueia acesso indevido
- [ ] Rate limiting ativo nas rotas de auth
- [ ] 2FA pode ser ativado/desativado
