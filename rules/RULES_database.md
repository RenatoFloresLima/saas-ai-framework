# 🗄 RULES_DATABASE — Regras de Banco de Dados

## Modelagem

```
[DB-01] Todo modelo tem: id (cuid), createdAt, updatedAt, deletedAt?
[DB-02] Nomes de tabelas: snake_case, plural (users, organizations, projects)
[DB-03] Nomes de colunas: camelCase no schema Prisma, snake_case no banco via @map
[DB-04] FKs sempre indexadas
[DB-05] Campos de busca/filtro frequente indexados
[DB-06] Unique constraints para campos únicos por tenant: @@unique([orgId, slug])
[DB-07] Soft delete: deletedAt DateTime? — nunca deletar fisicamente recursos de negócio
[DB-08] Enums: definir no Prisma para garantia de integridade
[DB-09] Decimais monetários: Decimal @db.Decimal(10,2) — nunca Float para dinheiro
[DB-10] Datas: sempre DateTime com timezone (PostgreSQL timestamptz)
```

## Queries

```
[DB-Q-01] Sempre filtrar deletedAt: null em queries de negócio
[DB-Q-02] Sempre filtrar por organizationId (isolamento de tenant)
[DB-Q-03] Usar select para buscar apenas campos necessários em listas
[DB-Q-04] Usar include com select nested para evitar over-fetching
[DB-Q-05] Paginação obrigatória em qualquer listagem (default: 20, max: 100)
[DB-Q-06] Transactions para operações multi-tabela (ex: criar org + member)
[DB-Q-07] Nunca usar findMany sem where + take (pode retornar toda tabela)
```

## Migrations

```
[DB-M-01] Nunca DROP COLUMN em produção sem período de deprecação
[DB-M-02] Colunas novas obrigatórias devem ter default ou serem nullable
[DB-M-03] Renomear coluna = adicionar nova + migrar dados + remover antiga (3 deploys)
[DB-M-04] Migrations devem ser reversíveis quando possível
[DB-M-05] Testar migration em cópia do banco de produção antes de aplicar
```
