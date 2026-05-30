import { logoutAction } from "@/actions/auth/logout"
import { Button } from "@/components/ui/button"
import { getRoleLabel } from "@/lib/auth/rbac"
import type { SessionUser } from "@/types"

/**
 * Menu do usuário no header do dashboard (Server Component friendly).
 * Copiar para: src/components/auth/dashboard-user-menu.tsx
 *
 * Usar no layout do dashboard com user de getCurrentUser() — não use apenas useSession() no header.
 */
interface DashboardUserMenuProps {
  user: SessionUser
}

export function DashboardUserMenu({ user }: DashboardUserMenuProps) {
  return (
    <div className="flex items-center gap-4">
      <div className="hidden text-right text-sm sm:block">
        <p className="font-medium">{user.name ?? user.email}</p>
        {user.role && <p className="text-muted-foreground">{getRoleLabel(user.role)}</p>}
      </div>
      <form action={logoutAction}>
        <Button type="submit" variant="outline" size="sm">
          Sair
        </Button>
      </form>
    </div>
  )
}
