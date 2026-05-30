# 🏢 TEMPLATE: business_context.md

> Este arquivo descreve o negócio para o qual o SaaS está sendo construído.
> Os agents usam este contexto para tomar decisões de domínio durante a geração de código.

---

## Descrição do Negócio

```
Nome do SaaS: [ex: Flowdesk — CRM para pequenas agências]
Tagline: [ex: "Gerencie clientes, projetos e faturas em um só lugar"]

O que o produto faz:
[Descrição em 2-3 frases do problema que resolve e como resolve]
ex: O Flowdesk é um CRM simplificado para agências de marketing e design.
    Permite gerenciar clientes, projetos, tarefas e emitir propostas/contratos,
    tudo integrado com pagamentos via Stripe.

Público-alvo:
[Quem são os usuários principais]
ex: Donos de agências pequenas (1-10 pessoas), freelancers que atendem múltiplos clientes

Modelo de negócio:
[Como o SaaS ganha dinheiro]
ex: SaaS B2B com planos mensais/anuais. Plano Free limitado para captar leads,
    plano Pro para usuários engajados.
```

---

## Entidades Principais do Domínio

> Liste as entidades principais do negócio (além das entidades base como User, Organization).
> Para cada uma, descreva os campos mais importantes e relacionamentos.

```yaml
entidades:

  - nome: Client
    descricao: "Cliente da agência"
    campos_principais:
      - name: string
      - email: string
      - phone: string?
      - company: string?
      - status: LEAD | ACTIVE | INACTIVE | CHURNED
      - notes: string?
    relacionamentos:
      - pertence a: Organization
      - tem muitos: Projects, Contacts, Notes
    regras_negocio:
      - "Um client pertence exclusivamente a uma Organization"
      - "Ao desativar um client, projetos em andamento recebem alerta"

  - nome: Project
    descricao: "Projeto para um cliente"
    campos_principais:
      - name: string
      - description: string?
      - status: PLANNING | ACTIVE | ON_HOLD | COMPLETED | CANCELED
      - startDate: date?
      - endDate: date?
      - budget: decimal?
    relacionamentos:
      - pertence a: Organization
      - pertence a: Client
      - tem muitos: Tasks, TimeEntries, Invoices
    regras_negocio:
      - "Apenas planos Pro+ podem ter mais de 3 projetos ativos"
      - "Budget não pode ser negativo"

  - nome: Task
    descricao: "Tarefa dentro de um projeto"
    campos_principais:
      - title: string
      - description: string?
      - status: TODO | IN_PROGRESS | IN_REVIEW | DONE
      - priority: LOW | MEDIUM | HIGH | URGENT
      - dueDate: date?
      - assigneeId: FK User
    relacionamentos:
      - pertence a: Project
      - pertence a: User (assignee)
    regras_negocio:
      - "Tarefa só pode ser assignada a membros do projeto"

# ADICIONE MAIS ENTIDADES CONFORME SEU NEGÓCIO...
```

---

## Fluxos Principais do Usuário

> Descreva os 3-5 fluxos mais importantes que o sistema deve suportar.

```
Fluxo 1: Onboarding
1. Usuário se registra
2. Verifica email
3. Cria organização (nome da agência)
4. Tour rápido do produto
5. Fica no plano Free

Fluxo 2: Adicionar cliente e projeto
1. Usuário na dashboard clica em "Novo Cliente"
2. Preenche dados do cliente
3. Cria um projeto para o cliente
4. Adiciona tarefas ao projeto
5. Convida colaborador (se plano permitir)

Fluxo 3: Upgrade de plano
1. Usuário atinge limite do Free (ex: 3 projetos)
2. Sistema mostra gate de upgrade
3. Usuário vai para página de pricing
4. Seleciona plano Pro e clica em Assinar
5. Stripe checkout (cartão)
6. Retorna para app com plano ativo

Fluxo 4: Convite de membro
1. Admin vai em Settings > Membros
2. Insere email e seleciona role
3. Convidado recebe email com link
4. Aceita convite e entra na organização
```

---

## Regras de Negócio Críticas

> Liste as regras mais importantes que o sistema DEVE garantir.

```
1. [Isolamento] Dados de uma organização NUNCA são visíveis para outra
2. [Limites] Verificar limite de plano ANTES de criar recurso, não depois
3. [Roles] Somente OWNER pode deletar a organização
4. [Roles] Somente OWNER e ADMIN podem convidar membros
5. [Billing] Downgrade de plano não exclui dados imediatamente — dá 30 dias
6. [GDPR] Usuário pode solicitar exclusão de conta — dados anonimizados, não deletados
7. [Soft Delete] Recursos deletados ficam na lixeira por 30 dias antes de exclusão permanente
```

---

## Integrações Externas (além das base)

```yaml
integracoes:
  - nome: Calendly
    proposito: "Agendamento de reuniões com clientes"
    tipo: OAuth + Webhook
    prioridade: FUTURA

  - nome: Google Calendar
    proposito: "Sincronizar datas de projetos"
    tipo: OAuth
    prioridade: FUTURA

  # ADICIONE INTEGRAÇÕES DO SEU NEGÓCIO...
```

---

## Dashboard — Métricas Principais

> O que o usuário quer ver na tela inicial?

```
- Total de clientes ativos
- Projetos em andamento
- Tarefas vencidas (urgente)
- Receita do mês (para owners)
- Atividade recente (últimas ações do time)
- [adicionar métricas relevantes ao negócio]
```

---

## Notificações

> Quando o sistema deve enviar emails/notificações?

```
Email:
- Convite de membro recebido
- Tarefa assignada a você
- Projeto próximo da deadline (3 dias antes)
- Fatura paga pelo cliente
- Trial expirando (3 dias antes)

In-app (se habilitado):
- Menção em comentário
- Status de projeto alterado
- Nova tarefa assignada
```
