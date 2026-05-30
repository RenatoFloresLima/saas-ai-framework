# 📡 RULES_API_DESIGN — Padrões de API

## REST API Routes (Next.js)

```typescript
// Estrutura de resposta SEMPRE consistente:

// Sucesso com dados:
{ success: true, data: T, meta?: PaginationMeta }

// Sucesso sem dados (DELETE, etc.):
{ success: true }

// Erro:
{ success: false, error: { code: string, message: string, details?: unknown } }

// Códigos de erro padronizados:
UNAUTHORIZED         // 401 - não autenticado
FORBIDDEN            // 403 - autenticado mas sem permissão
NOT_FOUND            // 404 - recurso não existe
VALIDATION_ERROR     // 422 - input inválido
RATE_LIMITED         // 429 - muitas requisições
INTERNAL_ERROR       // 500 - erro interno
PLAN_LIMIT_REACHED   // 402 - limite do plano atingido
```

## Status HTTP Corretos

```
200 OK              → GET bem-sucedido, UPDATE bem-sucedido
201 Created         → POST/criação bem-sucedida
204 No Content      → DELETE bem-sucedido
400 Bad Request     → input malformado (JSON inválido)
401 Unauthorized    → não autenticado
403 Forbidden       → autenticado mas sem permissão
404 Not Found       → recurso não existe
409 Conflict        → conflito (email duplicado, etc.)
422 Unprocessable   → validação de negócio falhou
429 Too Many Req.   → rate limit
500 Internal Error  → erro não previsto
```

## Paginação Padrão

```typescript
// Query params de entrada:
?page=1&limit=20&sortBy=createdAt&sortOrder=desc&search=texto&status=ACTIVE

// Resposta com meta:
{
  success: true,
  data: [...],
  meta: {
    total: 150,
    page: 1,
    limit: 20,
    totalPages: 8,
    hasNext: true,
    hasPrev: false
  }
}
```
