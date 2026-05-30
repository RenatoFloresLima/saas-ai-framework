# Padrões obrigatórios — Auth UI & OAuth

## 1. PasswordInput (mostrar/ocultar senha)

Todo campo de senha em login, registro e reset **deve** usar `PasswordInput` (`references/auth/password-input.tsx`), não `<Input type="password" />` sem toggle.

Integração com React Hook Form: `{...form.register("password")}`.

## 2. Google OAuth

### Provider (`src/auth.ts`)

```typescript
Google({
  clientId: process.env.GOOGLE_CLIENT_ID!,
  clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
  allowDangerousEmailAccountLinking: false,
  authorization: {
    params: { prompt: "select_account" },
  },
}),
```

Registrar o provider **somente** se `GOOGLE_CLIENT_ID` e `GOOGLE_CLIENT_SECRET` existirem.

### Botão social

- Usar `isGoogleOAuthEnabled()` de `src/lib/auth/oauth.ts`
- Na página de login/registro (Server Component), passar `googleOAuthEnabled={isGoogleOAuthEnabled()}` ao formulário
- Não exibir "Continuar com Google" se OAuth não estiver configurado

### Erros na UI

- `auth.config.ts`: `pages.error: "/login"`
- `LoginForm`: ler `searchParams.get("error")` e mapear com `getOAuthErrorMessage()`
- Mensagem amigável para `OAuthAccountNotLinked` (email já cadastrado com senha)

### `.env.example`

Incluir `AUTH_URL`, `NEXTAUTH_URL` e comentário com URI de redirect:
`{AUTH_URL}/api/auth/callback/google`

## 3. Logout (não depender só do cliente)

### Problema a evitar

`UserButton` com `useSession()` no header costuma retornar `null` com estratégia JWT — usuário logado sem botão "Sair".

### Solução padrão

1. **Layout do dashboard** (Server Component): `await auth()` + `getCurrentUser()` → renderizar `DashboardUserMenu` com botão "Sair"
2. **Sidebar**: `<form action={logoutAction}>` com item "Sair" no rodapé
3. **Layout raiz**: `AuthSessionProvider session={await auth()}` para hidratar o cliente

`logoutAction` chama `signOut({ redirectTo: "/login" })` e registra audit log.

## 4. SessionProvider

```typescript
// app/layout.tsx (async Server Component)
const session = await auth()
return (
  <AuthSessionProvider session={session}>{children}</AuthSessionProvider>
)
```

## 5. Escopo do framework

- Este repositório **não** contém o app SaaS gerado
- Gerar arquivos apenas no workspace/pasta do projeto do usuário
- Nomes, logo e copy vêm de `templates/project_config.md` e `NEXT_PUBLIC_APP_NAME`
