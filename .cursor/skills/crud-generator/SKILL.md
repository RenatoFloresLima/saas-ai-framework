---
name: crud-generator
description: Gera CRUD completo para uma entidade — schema Prisma, server actions, API routes, listagem, formulários e testes. Use quando o usuário pedir CRUD, nova entidade ou recurso REST completo.
---

# CRUD Generator

Leia e siga integralmente `subagents/crud_generator.md`.

## Antes de gerar

1. Confirme nome da entidade, campos, relacionamentos e regras de negócio.
2. Leia o schema Prisma atual para evitar conflitos.
3. Aplique `.cursor/rules/api-design.mdc` e `.cursor/rules/database.mdc`.

## Saída esperada

- Model Prisma + migration
- Server actions (create, update, delete, list)
- Página de listagem com paginação e filtros
- Formulário de criação/edição
- Testes básicos
