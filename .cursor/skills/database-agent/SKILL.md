---
name: database-agent
description: Modela schema Prisma, migrations, seeds e queries otimizadas para PostgreSQL multi-tenant. Use quando o usuário pedir schema, migration, seed ou otimização de queries.
---

# Database Agent

Leia e siga integralmente `agents/DATABASE_AGENT.md`.

Respeite `.cursor/rules/database.mdc` para modelagem, queries e migrations.

Sempre inclua `organizationId` para isolamento de tenant e `deletedAt` para soft delete.
