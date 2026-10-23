<p align="center">
  <img src="./logo.png" alt="i-have-adhd-zh" width="140" />
</p>
<p align="center">
  <strong>給 ADHD 讀者的 AI 回覆規則，中文版。不需要 ADHD 診斷也能用。</strong>
</p>
<p align="center">
  <strong>正體中文</strong> · <a href="README.zh-CN.md">简体中文</a>
</p>

這是 [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) 的中文改編版。原專案只收英文規則和簡體 README，這裡把規則本身翻成中文，並讓 AI 直接用中文回覆。

- `/adhd-tw`：正體中文（台灣用語）
- `/adhd-cn`：简体中文

只支援 **Claude Code** 和 **Codex**。

## 安裝

### Claude Code

```bash
claude plugin marketplace add ZilongRRR/i-have-adhd-zh
claude plugin install i-have-adhd-zh@i-have-adhd-zh
```

重開 Claude Code，輸入 `/adhd-tw` 或 `/adhd-cn`。

如果裝過英文原版，先移除，避免兩份規則同時注入：

```bash
claude plugin uninstall i-have-adhd
rm -f ~/.claude/.i-have-adhd-always
```

**常駐（選用）**：每次開 session 自動套用，不用每次輸入指令。

```bash
echo tw > ~/.claude/.i-have-adhd-zh   # 正體
echo cn > ~/.claude/.i-have-adhd-zh   # 簡體
```

關閉常駐：`rm ~/.claude/.i-have-adhd-zh`。對話中說「關閉 ADHD 模式」只關閉本次對話。

**更新**：

```bash
claude plugin marketplace update i-have-adhd-zh
claude plugin update i-have-adhd-zh@i-have-adhd-zh
```

### Codex

```bash
codex plugin marketplace add ZilongRRR/i-have-adhd-zh --ref main
codex plugin add i-have-adhd-zh@i-have-adhd-zh
```

輸入 `$adhd-tw` 或 `$adhd-cn` 啟動。Codex 不會自動啟用。

**常駐（選用）**：把規則寫進 `~/.codex/AGENTS.md`，可重複執行。

```bash
git clone https://github.com/ZilongRRR/i-have-adhd-zh.git
sh i-have-adhd-zh/scripts/codex-always-on.sh tw   # 或 cn；off 移除
```

## 改了什麼

<table>
<tr>
<td width="50%">

**之前**

> 好問題！讓我想一下。你的登入流程有幾個部分：middleware、token 驗證、cookie 處理。看了一下 `src/auth.ts`，`verifyToken`（大約第 42 到 58 行）好像用的是舊版 `jsonwebtoken` 的 API。一個做法是更新套件、重寫這個函式。改完之後，你可能要跑一下登入相關的測試，確認沒壞掉。對了，你也可以順便看看整體的套件版本。希望有幫助！想深入的話再跟我說。

</td>
<td width="50%">

**之後**

> 改 `src/auth.ts:42` 的 token 驗證。
>
> 1. 打開 `src/auth.ts`
> 2. 把 `verifyToken`（第 42 到 58 行）換成下面的程式片段
> 3. 執行 `npm test -- auth.spec.ts`
>
> 下一步：如果有測試失敗，把第一行失敗訊息貼上來。

</td>
</tr>
</table>

## 十條規則

完整內容：[正體](skills/adhd-tw/SKILL.md) · [简体](skills/adhd-cn/SKILL.md)

1. 開頭就是下一步。
2. 多步驟要編號。
3. 結尾給一個具體的下一步。
4. 壓住岔題。
5. 每輪重述目前進度。
6. 時間估計要具體（「15 分鐘」，不是「一下下」）。
7. 讓完成的成果看得見。
8. 報錯用平實語氣。
9. 清單最多 5 項。
10. 不要開場白、不要總結、不要客套結尾。

## 和原版的差異

- 規則全文翻成中文，例句改成中文常見的說法（「好問題！」「希望有幫助」）。
- 加了一條「語言」規則：`adhd-tw` 用正體中文回覆，`adhd-cn` 用簡體中文回覆。
- 「關閉 ADHD 模式」「一般模式」都能關閉，英文的 `stop adhd mode` 也還能用。
- 只保留 Claude Code 和 Codex。常駐 hook 改用 `sh`，不需要 Node。

## 自訂

Fork 之後改 `skills/adhd-tw/SKILL.md` 或 `skills/adhd-cn/SKILL.md`，再把 `.claude-plugin/plugin.json` 的 `version` 加一，`claude plugin update` 才會抓到新版。

## 致謝

規則來自 [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)（Ayoub Ghriss），原版參考 J. Russell Ramsay 與 Anthony L. Rostain 的《The Adult ADHD Tool Kit》。

## 授權

[MIT](LICENSE)，保留原作者版權聲明。
