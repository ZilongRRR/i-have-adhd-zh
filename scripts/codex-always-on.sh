#!/usr/bin/env sh
# 把規則寫進 ~/.codex/AGENTS.md，讓 Codex 每次都套用。
# 用法：sh scripts/codex-always-on.sh tw|cn|off
set -e

variant="${1:-tw}"
agents="${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
begin='<!-- i-have-adhd-zh:begin -->'
end='<!-- i-have-adhd-zh:end -->'
script_dir=$(cd "$(dirname -- "$0")" && pwd)

mkdir -p "$(dirname "$agents")"
touch "$agents"

# 先移除舊的區塊，可重複執行。
tmp=$(mktemp)
awk -v b="$begin" -v e="$end" '$0 == b { skip = 1; next } $0 == e { skip = 0; next } !skip { print }' "$agents" > "$tmp"
mv "$tmp" "$agents"

case "$variant" in
  off) echo "已從 ${agents} 移除"; exit 0 ;;
  cn) skill=adhd-cn ;;
  tw) skill=adhd-tw ;;
  *) echo "用法：sh scripts/codex-always-on.sh tw|cn|off" >&2; exit 1 ;;
esac

{
  echo "$begin"
  awk 'NR == 1 && /^---[[:space:]]*$/ { fm = 1; next } fm && /^---[[:space:]]*$/ { fm = 0; next } !fm { print }' \
    "$script_dir/../skills/$skill/SKILL.md"
  echo "$end"
} >> "$agents"
echo "已寫入 ${agents}（${skill}）"
