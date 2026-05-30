# 📖 HOW TO USE — Guia de Uso do SaaS Framework

## Framework vs projeto gerado

| Repositório | Contém |
|-------------|--------|
| `saas-ai-framework` | Prompts, agents, `references/` (padrões), rules — **não** é o app |
| Seu SaaS (outra pasta) | `src/`, `prisma/`, `.env` — tudo que o orquestrador gera |

Ao rodar o orquestrador, abra o **workspace do projeto gerado** (ou indique o caminho em `project_config.md`). O SaaS default de auth está em `references/auth/` — a IA copia/adapta esses padrões na Fase 2.

Instale o framework no projeto SaaS com:

```bash
./scripts/install-in-project.sh ~/projetos/meu-saas
```

O script copia `references/`, `.cursor/`, agents, orchestrators e templates. **Não** aponte o script para a pasta do próprio `saas-ai-framework`.

---

## TL;DR — Versão Ultra Rápida

### Cursor (configuração já incluída)
```
1. Preencha templates/project_config.md
2. Preencha templates/business_context.md
3. No chat: "Use a skill saas-orchestrator"
4. Siga as fases em ordem (aprove cada uma)
5. 🎉
```

### Claude.ai / manual
```
1. Preencha templates/project_config.md
2. Preencha templates/business_context.md  
3. Abra o Claude / Cursor
4. Cole: RULES_global.md + RULES_security.md + MASTER_ORCHESTRATOR.md + os dois templates
5. Siga as fases em ordem
6. 🎉
```

---

## Como Usar com Claude.ai (Web/App)

### Passo 1: Prepare o contexto
Preencha os dois templates com as informações do seu projeto.

### Passo 2: Inicie uma nova conversa
Cole no início da conversa:

```
[Conteúdo de RULES_global.md]
---
[Conteúdo de RULES_security.md]
---
[Conteúdo de MASTER_ORCHESTRATOR.md]
---
[Conteúdo de project_config.md preenchido]
---
[Conteúdo de business_context.md preenchido]
```

### Passo 3: Aguarde o orquestrador responder
O Claude vai confirmar o entendimento e pedir aprovação antes de gerar código.

### Passo 4: Itere por fase
Após cada fase, confirme que tudo funciona antes de avançar.

---

## Como Usar com Cursor (IDE)

> **Configuração pronta:** este repositório já inclui `.cursor/rules/`, `.cursor/skills/` e `AGENTS.md`.
> Leia `AGENTS.md` na raiz para o mapa completo.

### Início rápido no Cursor

```
1. Preencha templates/project_config.md e templates/business_context.md
2. No chat: "Use a skill project-setup" (se os templates estiverem vazios)
3. No chat: "Use a skill saas-orchestrator para iniciar o projeto"
4. Aprove cada fase antes de avançar
```

### O que é automático

| Recurso | Pasta | Comportamento |
|---------|-------|---------------|
| Rules globais | `.cursor/rules/global.mdc` | Sempre ativas |
| Rules de segurança | `.cursor/rules/security.mdc` | Sempre ativas |
| Rules de API | `.cursor/rules/api-design.mdc` | Ao editar API/actions |
| Rules de banco | `.cursor/rules/database.mdc` | Ao editar Prisma |
| Skills | `.cursor/skills/*/SKILL.md` | Invocar pelo nome no chat |

### Invocar agents e fases

```
Use a skill saas-orchestrator
Use a skill phase-1-foundation
Use a skill crud-generator para a entidade Product
Use a skill auth-agent para adicionar OAuth GitHub
```

### Opção alternativa: contexto manual

Arraste arquivos de `agents/`, `orchestrators/` ou `templates/` para o chat quando precisar de contexto extra.

---

## Como Usar Agents Individualmente

Quando precisar de uma funcionalidade específica após o setup inicial:

### Exemplo 1: Gerar um novo CRUD

```
[Cole RULES_global.md]
[Cole RULES_code_quality.md]
[Cole RULES_api_design.md]
[Cole subagents/crud_generator.md]

Preciso gerar um CRUD completo para a entidade "Invoice" com os seguintes campos:
[descreva os campos]
```

### Exemplo 2: Adicionar um novo provider OAuth

```
[Cole RULES_security.md]
[Cole agents/AUTH_AGENT.md]
[Cole seu auth.ts atual]

Preciso adicionar autenticação com GitHub OAuth. 
O projeto já tem Google OAuth configurado.
```

### Exemplo 3: Novo plano de assinatura

```
[Cole RULES_security.md]
[Cole agents/BILLING_AGENT.md]
[Cole seu schema atual]

Preciso adicionar um plano "Starter" entre o Free e o Pro com os seguintes limites: [...]
```

---

## Mantendo o Contexto em Conversas Longas

O Claude tem limite de contexto. Para projetos grandes:

1. **Uma conversa por fase** — não tente fazer tudo em uma conversa
2. **Referencie arquivos já gerados** — cole o código atual quando for expandir
3. **Use "continue de onde parou"** — se a resposta truncar, peça para continuar
4. **Salve tudo imediatamente** — copie os arquivos gerados antes de continuar

---

## Estrutura de Conversa Ideal

```
Turno 1: Você → Cole contexto + peça para iniciar Fase 1
Turno 2: Claude → Confirma entendimento, lista decisões
Turno 3: Você → Aprova ou ajusta decisões
Turno 4: Claude → Gera arquivos da Fase 1 (pode ser longo)
Turno 5: Você → "Confirmado, pode continuar com a Fase 2"
...
```

---

## Dicas de Prompting

### ✅ Faça isso:
- Seja específico sobre o que quer: "Gere o arquivo `src/actions/auth/login.ts` completo"
- Forneça contexto: "O schema atual é [colar schema]"
- Diga o que já existe: "O AUTH_AGENT já gerou o NextAuth, agora preciso do RBAC"
- Peça código completo: "Código completo, sem truncar, sem placeholder"

### ❌ Evite:
- Pedidos vagos: "Gere o sistema de auth" (sem contexto)
- Assumir que o Claude lembra: sempre referencie arquivos existentes
- Avançar fases sem testar: confirme que cada fase funciona
- Pedir tudo de uma vez: divida em pedaços gerenciáveis

---

## Quando Algo der Errado

### Código incompleto gerado:
```
"O arquivo [nome] foi truncado. Por favor, continue a partir de [última linha visível]"
```

### Código com erro:
```
"Este código tem o seguinte erro: [colar erro]
Contexto adicional: [colar código relevante]
Por favor, corrija mantendo os mesmos padrões."
```

### Comportamento diferente do esperado:
```
"O agente deveria [comportamento esperado] mas está fazendo [comportamento atual].
Regra violada: [citar regra do RULES_*.md]
Por favor, corrija."
```

---

## Customização do Framework

Veja `docs/CUSTOMIZATION_GUIDE.md` para instruções sobre:
- Adicionar novas skills de stack (ex: SKILL_drizzle.md, SKILL_vue.md)
- Criar agents para domínios específicos do negócio
- Adaptar os templates para outro tipo de produto
- Adicionar suporte a Mercado Pago (Brasil)
