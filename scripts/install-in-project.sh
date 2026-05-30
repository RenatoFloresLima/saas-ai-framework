#!/usr/bin/env bash
# Instala o SaaS AI Framework em um projeto existente ou pasta vazia.
#
# Uso:
#   ./scripts/install-in-project.sh /caminho/do/seu/saas
#   ./scripts/install-in-project.sh .          # diretório atual (deve ser o projeto SaaS, não este repo)
#
# O código da aplicação (src/, prisma/, etc.) é gerado pelo orquestrador no projeto destino.
# Este script copia apenas prompts, rules, referências e configuração do Cursor.

set -euo pipefail

usage() {
  cat <<'EOF'
Instala o SaaS AI Framework em um projeto.

Uso:
  ./scripts/install-in-project.sh <caminho-do-projeto-saas>

O que é copiado/sincronizado:
  .cursor/rules, .cursor/skills  (sempre atualiza)
  references/                    (padrões SaaS default — auth, etc.)
  agents/, orchestrators/, subagents/, rules/, skills/, templates/
  docs/                          (guia de uso)
  AGENTS.md

Não use este script apontando para a pasta do próprio saas-ai-framework.
Abra o workspace do seu SaaS no Cursor após instalar.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
  echo "Erro: informe o caminho do projeto SaaS de destino." >&2
  echo ""
  usage
  exit 1
fi

FRAMEWORK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -d "$TARGET" ]]; then
  echo "Criando diretório de destino: $TARGET"
  mkdir -p "$TARGET"
fi

TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$FRAMEWORK_ROOT" ]]; then
  echo "Erro: o destino é o repositório do framework." >&2
  echo "Aponte para a pasta do seu SaaS, por exemplo:" >&2
  echo "  ./scripts/install-in-project.sh ~/projetos/meu-saas" >&2
  exit 1
fi

echo "Instalando SaaS AI Framework"
echo "  Origem:  $FRAMEWORK_ROOT"
echo "  Destino: $TARGET"
echo ""

# Copia pasta inteira apenas se ainda não existir no destino
copy_dir() {
  local name="$1"
  if [[ -d "$TARGET/$name" ]]; then
    echo "  ⚠  $name/ já existe — pulando (remova manualmente para recopiar do zero)"
  else
    cp -r "$FRAMEWORK_ROOT/$name" "$TARGET/$name"
    echo "  ✓  $name/"
  fi
}

# Sincroniza conteúdo (sobrescreve arquivos do framework; útil em reinstalação/atualização)
sync_dir() {
  local name="$1"
  if [[ ! -d "$FRAMEWORK_ROOT/$name" ]]; then
    echo "  ⚠  $name/ não encontrado na origem — pulando"
    return
  fi
  mkdir -p "$TARGET/$name"
  cp -r "$FRAMEWORK_ROOT/$name/." "$TARGET/$name/"
  echo "  ✓  $name/ (sincronizado)"
}

# .cursor: merge de rules e skills (sempre atualiza)
if [[ -d "$TARGET/.cursor" ]]; then
  echo "  ↻  .cursor/ — atualizando rules/ e skills/"
  mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
  cp -r "$FRAMEWORK_ROOT/.cursor/rules/." "$TARGET/.cursor/rules/"
  cp -r "$FRAMEWORK_ROOT/.cursor/skills/." "$TARGET/.cursor/skills/"
  echo "  ✓  .cursor/rules/ + .cursor/skills/"
else
  cp -r "$FRAMEWORK_ROOT/.cursor" "$TARGET/.cursor"
  echo "  ✓  .cursor/"
fi

# Referências canônicas (auth SaaS default) — sempre sincronizar
sync_dir "references"

copy_dir "agents"
copy_dir "orchestrators"
copy_dir "subagents"
copy_dir "rules"
copy_dir "skills"
copy_dir "templates"
sync_dir "docs"

if [[ -f "$TARGET/AGENTS.md" ]]; then
  echo "  ⚠  AGENTS.md já existe — pulando"
else
  cp "$FRAMEWORK_ROOT/AGENTS.md" "$TARGET/AGENTS.md"
  echo "  ✓  AGENTS.md"
fi

# Versão instalada (atualiza a cada execução)
{
  echo "installed_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  if command -v git >/dev/null 2>&1 && git -C "$FRAMEWORK_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
    echo "framework_commit=$(git -C "$FRAMEWORK_ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  fi
  echo "framework_root=$FRAMEWORK_ROOT"
} >"$TARGET/.saas-framework-version"
echo "  ✓  .saas-framework-version"

echo ""
echo "Instalação concluída!"
echo ""
echo "Próximos passos:"
echo "  1. Abra no Cursor: $TARGET"
echo "  2. Preencha templates/project_config.md (inclua o caminho deste projeto)"
echo "  3. Preencha templates/business_context.md"
echo "  4. No chat: Use a skill saas-orchestrator"
echo "  5. Na Fase 2, use references/auth/ como base do auth (ver references/auth/PATTERNS.md)"
echo ""
echo "Para atualizar rules/skills/referências depois, rode este script novamente no mesmo destino."
