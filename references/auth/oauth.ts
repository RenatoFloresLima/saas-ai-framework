/**
 * Helpers OAuth — copiar para: src/lib/auth/oauth.ts
 */

export function isGoogleOAuthEnabled(): boolean {
  return Boolean(process.env.GOOGLE_CLIENT_ID && process.env.GOOGLE_CLIENT_SECRET)
}

const OAUTH_ERROR_MESSAGES: Record<string, string> = {
  Configuration:
    "Login com Google não está configurado. Defina GOOGLE_CLIENT_ID e GOOGLE_CLIENT_SECRET.",
  AccessDenied: "Acesso negado. Você cancelou o login ou não autorizou o aplicativo.",
  OAuthSignin: "Não foi possível iniciar o login com Google. Verifique as credenciais OAuth.",
  OAuthCallback:
    "Erro ao retornar do Google. Confirme AUTH_URL/NEXTAUTH_URL e a URI de redirect: /api/auth/callback/google",
  OAuthAccountNotLinked:
    "Este email já está cadastrado com senha. Entre com email e senha ou use outra conta Google.",
  OAuthCreateAccount: "Não foi possível criar a conta com Google. Tente novamente.",
  Default: "Erro de autenticação. Tente novamente ou use email e senha.",
}

export function getOAuthErrorMessage(error: string | null | undefined): string | null {
  if (!error) return null
  return OAUTH_ERROR_MESSAGES[error] ?? OAUTH_ERROR_MESSAGES.Default
}
