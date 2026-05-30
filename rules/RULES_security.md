# 🔒 RULES_SECURITY — Regras de Segurança Invioláveis

> Estas regras NUNCA podem ser violadas, independente de contexto ou conveniência.
> Se houver conflito entre uma regra de conveniência e uma regra de segurança, a segurança vence.

---

## AUTENTICAÇÃO

```
[SEC-AUTH-01] Senhas sempre com bcrypt, salt rounds >= 12
[SEC-AUTH-02] NUNCA armazenar senha em plaintext, nem em log
[SEC-AUTH-03] Tokens de sessão: mínimo 256 bits de entropia
[SEC-AUTH-04] Tokens de reset/verify: one-time use (deletar após uso)
[SEC-AUTH-05] Tokens têm expiração: reset=30min, verify=1h, session=30d
[SEC-AUTH-06] Rate limiting obrigatório: 5 tentativas de login / 15min / IP
[SEC-AUTH-07] Mensagens de erro de auth genéricas ("Credenciais inválidas")
              — nunca revelar se email existe ou não
[SEC-AUTH-08] 2FA deve ser verificado ANTES de criar sessão completa
[SEC-AUTH-09] Logout deve invalidar sessão no servidor (não só no cliente)
[SEC-AUTH-10] OAuth: validar state parameter para prevenir CSRF
```

## AUTORIZAÇÃO

```
[SEC-AUTHZ-01] Verificar permissão em TODA operação (não confiar no frontend)
[SEC-AUTHZ-02] Verificar ownership: usuário só pode acessar SEUS recursos
[SEC-AUTHZ-03] Nunca expor IDs sequenciais — usar UUIDs/CUIDs
[SEC-AUTHZ-04] Isolamento de tenant: SEMPRE filtrar por organizationId
[SEC-AUTHZ-05] Operações de admin devem re-verificar role no servidor
```

## DADOS E INPUTS

```
[SEC-DATA-01] Validar TODOS os inputs com Zod antes de processar
[SEC-DATA-02] Sanitizar inputs antes de renderizar como HTML (DOMPurify)
[SEC-DATA-03] Nunca fazer query SQL raw com interpolação de string
             → Prisma previne por padrão; se usar $queryRaw, usar tagged templates
[SEC-DATA-04] Nunca expor dados sensíveis em URLs ou logs
[SEC-DATA-05] Dados PII (CPF, cartão, etc.): nunca logar
[SEC-DATA-06] Mascarar dados sensíveis em respostas de API
             (email: u***@gmail.com, cartão: ****1234)
[SEC-DATA-07] Uploads: validar tipo MIME, tamanho e nome do arquivo
[SEC-DATA-08] Redirect após auth: validar URL de callback (whitelist de domínios)
```

## APIs E ENDPOINTS

```
[SEC-API-01] Toda API route deve verificar autenticação
[SEC-API-02] Rate limiting em todas as rotas públicas
[SEC-API-03] CORS configurado explicitamente (não usar wildcard *)
[SEC-API-04] Webhooks: SEMPRE verificar assinatura do provider
[SEC-API-05] Nunca expor stack trace ou mensagem de erro do banco ao cliente
[SEC-API-06] Respostas de erro padronizadas (não vazar detalhes internos)
[SEC-API-07] Métodos HTTP corretos: GET=leitura, POST=criação, PATCH=atualização parcial,
             PUT=substituição, DELETE=remoção
```

## SEGREDOS E CONFIGURAÇÃO

```
[SEC-CONF-01] Nunca commitar secrets (.env não entra no git)
[SEC-CONF-02] .env.example deve ter valores de exemplo, NÃO reais
[SEC-CONF-03] Verificar variáveis obrigatórias na inicialização da app
[SEC-CONF-04] Rotacionar secrets comprometidos IMEDIATAMENTE
[SEC-CONF-05] DEBUG e logs detalhados desabilitados em produção
```

## HEADERS HTTP

```
[SEC-HDR-01] Strict-Transport-Security (HSTS): obrigatório em produção
[SEC-HDR-02] X-Frame-Options: SAMEORIGIN (previne clickjacking)
[SEC-HDR-03] X-Content-Type-Options: nosniff
[SEC-HDR-04] Content-Security-Policy: configurado (adaptar por necessidade)
[SEC-HDR-05] Referrer-Policy: origin-when-cross-origin
```

## AUDITORIA E LOGS

```
[SEC-LOG-01] Logar: logins (sucesso e falha), logouts, mudanças de role,
             deleções, acessos a dados sensíveis
[SEC-LOG-02] Cada log deve ter: timestamp, userId, ação, IP, resultado
[SEC-LOG-03] NUNCA logar: senhas, tokens, dados de cartão, dados PII completos
[SEC-LOG-04] Logs devem ser imutáveis (append-only, não editáveis)
[SEC-LOG-05] Retenção de logs de auditoria: mínimo 90 dias
```

## DEPENDÊNCIAS

```
[SEC-DEP-01] Verificar vulnerabilidades conhecidas antes de adicionar dependência
[SEC-DEP-02] Atualizar dependências com vulnerabilidades críticas imediatamente
[SEC-DEP-03] Revisar permissões de packages de terceiros
```

---

## Quick Reference — Checklist por Feature

### Ao criar qualquer endpoint/action:
- [ ] Autenticação verificada?
- [ ] Autorização verificada (role + ownership)?
- [ ] Input validado com Zod?
- [ ] Errors tratados e não expostos?
- [ ] Rate limiting aplicado (se público)?
- [ ] Ação logada no AuditLog (se sensível)?

### Ao criar qualquer formulário:
- [ ] Validação no cliente (UX) E no servidor (segurança)?
- [ ] Campos sensíveis com autocomplete correto?
- [ ] Proteção CSRF?
- [ ] Mensagens de erro não revelam informações internas?
