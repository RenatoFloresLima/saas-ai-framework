# Referência — Auth (SaaS default)

Implementações **canônicas** para qualquer projeto gerado pelo orquestrador. O agente deve **copiar/adaptar** estes arquivos no **diretório do SaaS do usuário** (ex.: pasta criada na Fase 1), nunca commitar código de app dentro deste repositório do framework.

## Quando usar

- Fase 2 (`orchestrators/PHASE_2_auth_security.md`)
- Skill `auth-agent` ou `phase-2-auth-security`
- Correções de UX em login/OAuth/logout

## Arquivos

| Referência | Destino no projeto gerado |
|------------|---------------------------|
| `password-input.tsx` | `src/components/ui/password-input.tsx` |
| `oauth.ts` | `src/lib/auth/oauth.ts` |
| `dashboard-user-menu.tsx` | `src/components/auth/dashboard-user-menu.tsx` |
| `session-provider.tsx` | `src/components/providers/session-provider.tsx` |
| `PATTERNS.md` | Regras obrigatórias (ler antes de gerar UI de auth) |

## Checklist UX (obrigatório no SaaS default)

- [ ] Campos de senha usam `PasswordInput` (toggle mostrar/ocultar)
- [ ] Google OAuth com `prompt: "select_account"`
- [ ] Botão social só se `GOOGLE_CLIENT_*` estiver definido
- [ ] Erros OAuth exibidos na página de login (`?error=`)
- [ ] Logout no header **e** na sidebar (sessão via servidor, não só `useSession()`)
- [ ] `SessionProvider` recebe `session` de `await auth()` no layout raiz
