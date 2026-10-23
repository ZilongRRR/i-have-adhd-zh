#!/usr/bin/env sh
# SessionStart hook：使用者建立旗標檔後，每次開 session 自動注入整份規則。
# 旗標檔：$CLAUDE_CONFIG_DIR/.i-have-adhd-zh（預設 ~/.claude/.i-have-adhd-zh）
# 檔案內容寫 cn 用簡體版，其他（含空檔）用正體版。
# 任何錯誤都 exit 0，不擋 session 啟動。

claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
flag_path="$claude_dir/.i-have-adhd-zh"

[ -f "$flag_path" ] || exit 0

variant=$(tr -d '[:space:]' < "$flag_path" 2>/dev/null)
case "$variant" in
  cn|zh-cn|zh-CN) skill=adhd-cn ;;
  *) skill=adhd-tw ;;
esac

script_dir=$(dirname -- "$0")
skill_path="$script_dir/../skills/$skill/SKILL.md"
[ -f "$skill_path" ] || exit 0

# 去掉檔案最前面的 YAML frontmatter（--- ... ---）。
body=$(awk '
  NR == 1 && /^---[[:space:]]*$/ { in_fm = 1; next }
  in_fm && /^---[[:space:]]*$/   { in_fm = 0; next }
  !in_fm { print }
' "$skill_path") || exit 0

if [ "$skill" = adhd-cn ]; then
  printf 'ADHD 模式已开启（常驻）。以下规则适用于每一条回复。说「关闭 ADHD 模式」可在本次会话关闭；删除 %s 可永久关闭常驻。\n\n%s\n' "$flag_path" "$body"
else
  printf 'ADHD 模式已開啟（常駐）。以下規則適用於每一則回覆。說「關閉 ADHD 模式」可在本次對話關閉；刪除 %s 可永久關閉常駐。\n\n%s\n' "$flag_path" "$body"
fi
exit 0
