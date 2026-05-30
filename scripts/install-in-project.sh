#!/usr/bin/env bash
# Instala o SaaS AI Framework em um projeto existente ou pasta vazia.
# Uso: ./scripts/install-in-project.sh /caminho/do/seu/projeto

set -euo pipefail

TARGET="${1:-.}"
FRAMEWORK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$(cd "$TARGET" && pwd)"

echo "Instalando SaaS AI Framework em: $TARGET"
echo "Origem: $FRAMEWORK_ROOT"
echo ""

copy_dir() {
  local name="$1"
  if [ -d "$TARGET/$name" ]; then
    echo "  ⚠  $name/ já existe — pulando (remova manualmente se quiser sobrescrever)"
  else
    cp -r "$FRAMEWORK_ROOT/$name" "$TARGET/$name"
    echo "  ✓  $name/"
  fi
}

# .cursor precisa merge cuidadoso se já existir
if [ -d "$TARGET/.cursor" ]; then
  echo "  ⚠  .cursor/ já existe — copiando rules/ e skills/ dentro dele"
  mkdir -p "$TARGET/.cursor/rules" "$TARGET/.cursor/skills"
  cp -r "$FRAMEWORK_ROOT/.cursor/rules/." "$TARGET/.cursor/rules/"
  cp -r "$FRAMEWORK_ROOT/.cursor/skills/." "$TARGET/.cursor/skills/"
  echo "  ✓  .cursor/rules/ + .cursor/skills/"
else
  cp -r "$FRAMEWORK_ROOT/.cursor" "$TARGET/.cursor"
  echo "  ✓  .cursor/"
fi

copy_dir "agents"
copy_dir "orchestrators"
copy_dir "subagents"
copy_dir "rules"
copy_dir "skills"
copy_dir "templates"

if [ -f "$TARGET/AGENTS.md" ]; then
  echo "  ⚠  AGENTS.md já existe — pulando"
else
  cp "$FRAMEWORK_ROOT/AGENTS.md" "$TARGET/AGENTS.md"
  echo "  ✓  AGENTS.md"
fi

echo ""
echo "Instalação concluída!"
echo ""
echo "Próximos passos:"
echo "  1. Abra $TARGET no Cursor"
echo "  2. Preencha templates/project_config.md e templates/business_context.md"
echo "  3. No chat: Use a skill saas-orchestrator"
