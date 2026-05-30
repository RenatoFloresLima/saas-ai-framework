"use client"

import { SessionProvider } from "next-auth/react"
import type { Session } from "next-auth"

/**
 * Copiar para: src/components/providers/session-provider.tsx
 * No app/layout.tsx (async): const session = await auth()
 * <AuthSessionProvider session={session}>{children}</AuthSessionProvider>
 */
export function AuthSessionProvider({
  children,
  session,
}: {
  children: React.ReactNode
  session?: Session | null
}) {
  return <SessionProvider session={session}>{children}</SessionProvider>
}
