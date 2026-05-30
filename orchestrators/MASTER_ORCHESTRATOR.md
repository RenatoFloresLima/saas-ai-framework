# 🎛 MASTER ORCHESTRATOR — SaaS Generator

## Propósito
Este é o arquivo de entrada do framework. Ele coordena todos os agents, define a ordem de execução e garante que cada fase seja completada antes de avançar.

---

## 📥 Inputs Necessários

Antes de iniciar, você deve ter preenchido:
- `templates/project_config.md` → stack técnica, nome do projeto, preferências
- `templates/business_context.md` → o que o SaaS faz, usuários-alvo, funcionalidades do negócio

---

## 🔁 Prompt de Entrada (cole este prompt no Claude/Cursor)

```
Você é o MASTER ORCHESTRATOR de um framework para geração de aplicações SaaS.

Seu papel é coordenar a geração de uma aplicação SaaS completa e pronta para produção seguindo as fases definidas abaixo.

## Contexto do Projeto
[COLE O CONTEÚDO DE project_config.md AQUI]

## Contexto do Negócio
[COLE O CONTEÚDO DE business_context.md AQUI]

## Regras Globais
Você DEVE sempre seguir as regras em RULES_global.md, RULES_security.md e RULES_code_quality.md. Nunca gere código que viole essas regras.

## Sua Tarefa
1. Confirme o entendimento do projeto com um resumo de 5 bullets
2. Liste as decisões técnicas que tomará e peça aprovação
3. Após aprovação, execute a FASE 1 (foundation)
4. Aguarde confirmação antes de cada fase subsequente
5. Ao final de cada fase, liste o que foi gerado e o que vem a seguir

## Formato de Saída
Para cada arquivo gerado:
- Mostre o caminho completo: `src/lib/auth/session.ts`
- Mostre o código completo, sem truncar
- Adicione comentários explicativos nas partes importantes
- Sinalize com [CONFIGURAR] onde o dev precisa preencher valores

Comece agora com o passo 1.
```

---

## 📋 Fases de Execução

### FASE 1 — Foundation
**Orquestrador:** `PHASE_1_foundation.md`
**Agent Principal:** `ARCHITECT_AGENT.md`
**O que gera:**
- Estrutura de pastas do projeto
- `package.json` com dependências
- Arquivos de configuração (tsconfig, eslint, prettier)
- `.env.example` documentado
- `docker-compose.yml`
- Configuração do banco de dados (Prisma schema base)

**Critério de conclusão:** Projeto roda localmente com `npm run dev`

---

### FASE 2 — Auth & Security
**Orquestrador:** `PHASE_2_auth_security.md`
**Agents:** `AUTH_AGENT.md`, `SECURITY_AGENT.md`, `DATABASE_AGENT.md`
**O que gera:**
- Schema de usuários, sessões, tokens
- Sistema de autenticação completo
- Middleware de autorização (RBAC)
- Páginas de auth (login, registro, recuperação de senha)
- Guards e HOCs de proteção

**Critério de conclusão:** Usuário consegue se registrar, logar, e logout. RBAC funcionando.

---

### FASE 3 — Billing & Plans
**Orquestrador:** `PHASE_3_billing.md`
**Agent Principal:** `BILLING_AGENT.md`
**O que gera:**
- Schema de planos, assinaturas, faturas
- Integração Stripe completa
- Páginas de pricing, checkout, portal de billing
- Webhook handler
- Controle de features por plano (feature flags)
- Emails transacionais de billing

**Critério de conclusão:** Usuário consegue assinar um plano e ser cobrado.

---

### FASE 4 — Core Features
**Orquestrador:** `PHASE_4_core_features.md`
**Agents:** `FRONTEND_AGENT.md`, `API_AGENT.md`, `DATABASE_AGENT.md`
**O que gera:**
- Dashboard principal
- Gerenciamento de perfil e conta
- Sistema de workspace/organização
- Convite de membros
- Configurações da aplicação
- Componentes UI reutilizáveis

**Critério de conclusão:** App navegável com todas as páginas estruturais prontas.

---

### FASE 5 — Deploy & Observability
**Orquestrador:** `PHASE_5_deploy.md`
**Agent Principal:** `DEVOPS_AGENT.md`
**O que gera:**
- Configuração Vercel/Railway
- GitHub Actions CI/CD
- Configuração de logs (estruturado)
- Health check endpoint
- Documentação de deploy
- Checklist de produção

**Critério de conclusão:** App deployado e acessível publicamente.

---

## 🔀 Uso Avulso (por Agent)

Você também pode usar agents individualmente para tarefas específicas:

```
# Exemplo: Gerar um CRUD completo para uma entidade
Carregue: RULES_global.md + RULES_code_quality.md + SKILL_prisma.md + subagents/crud_generator.md

Entidade: [NOME DA ENTIDADE]
Campos: [LISTA DE CAMPOS]
Relacionamentos: [RELACIONAMENTOS]
Regras de negócio: [REGRAS ESPECÍFICAS]
```

---

## ⚠️ Ordem de Dependências

```
project_config + business_context
        ↓
   FASE 1 (Foundation)
        ↓
   FASE 2 (Auth) ← depende do schema base da Fase 1
        ↓
   FASE 3 (Billing) ← depende do sistema de usuários da Fase 2
        ↓
   FASE 4 (Core) ← depende de auth + billing prontos
        ↓
   FASE 5 (Deploy) ← depende de app funcional
```

**Nunca pule fases.** Cada fase constrói sobre a anterior.
