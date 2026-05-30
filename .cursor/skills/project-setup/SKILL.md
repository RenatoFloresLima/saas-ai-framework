---
name: project-setup
description: Guia o preenchimento dos templates project_config e business_context antes de gerar o SaaS. Use quando iniciar um novo projeto ou quando os templates ainda estiverem vazios.
---

# Project Setup

## Instruções

1. Leia `templates/project_config.md` e `templates/business_context.md`.
2. Pergunte ao usuário as informações faltantes, seção por seção.
3. Preencha os templates com as respostas (substitua os placeholders `[...]`).
4. Valide que stack, entidades de domínio e planos de pricing estão definidos.
5. Quando completos, sugira iniciar com a skill `saas-orchestrator`.

## Campos críticos

- Nome do projeto, slug, domínio, idioma, moeda
- Stack (frontend, backend, DB, auth, pagamentos)
- Entidades de domínio e relacionamentos
- Planos e limites por tier
