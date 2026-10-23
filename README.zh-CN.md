<p align="center">
  <img src="./logo.png" alt="i-have-adhd-zh" width="140" />
</p>
<p align="center">
  <strong>给 ADHD 读者的 AI 回复规则，中文版。不需要 ADHD 诊断也能用。</strong>
</p>
<p align="center">
  <a href="README.md">正體中文</a> · <strong>简体中文</strong>
</p>

这是 [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) 的中文改编版。原项目只有英文规则，这里把规则本身翻成中文，并让 AI 直接用中文回复。

- `/adhd-cn`：简体中文
- `/adhd-tw`：正體中文（台湾用语）

只支持 **Claude Code** 和 **Codex**。

## 安装

### Claude Code

```bash
claude plugin marketplace add ZilongRRR/i-have-adhd-zh
claude plugin install i-have-adhd-zh@i-have-adhd-zh
```

重启 Claude Code，输入 `/adhd-cn` 或 `/adhd-tw`。

如果装过英文原版，先卸载，避免两份规则同时注入：

```bash
claude plugin uninstall i-have-adhd
rm -f ~/.claude/.i-have-adhd-always
```

**常驻（可选）**：每次开会话自动应用，不用每次输入命令。

```bash
echo cn > ~/.claude/.i-have-adhd-zh   # 简体
echo tw > ~/.claude/.i-have-adhd-zh   # 正體
```

关闭常驻：`rm ~/.claude/.i-have-adhd-zh`。对话中说「关闭 ADHD 模式」只关闭本次会话。

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

输入 `$adhd-cn` 或 `$adhd-tw` 启动。Codex 不会自动启用。

**常驻（可选）**：把规则写进 `~/.codex/AGENTS.md`，可重复执行。

```bash
git clone https://github.com/ZilongRRR/i-have-adhd-zh.git
sh i-have-adhd-zh/scripts/codex-always-on.sh cn   # 或 tw；off 移除
```

## 改了什么

<table>
<tr>
<td width="50%">

**之前**

> 好问题！让我想一下。你的登录流程有几个部分：middleware、token 校验、cookie 处理。看了一下 `src/auth.ts`，`verifyToken`（大约第 42 到 58 行）好像用的是旧版 `jsonwebtoken` 的 API。一个做法是升级依赖、重写这个函数。改完之后，你可能要跑一下登录相关的测试，确认没坏。对了，你也可以顺便看看整体的依赖版本。希望对你有帮助！想深入的话再告诉我。

</td>
<td width="50%">

**之后**

> 改 `src/auth.ts:42` 的 token 校验。
>
> 1. 打开 `src/auth.ts`
> 2. 把 `verifyToken`（第 42 到 58 行）换成下面的代码片段
> 3. 运行 `npm test -- auth.spec.ts`
>
> 下一步：如果有测试失败，把第一行失败信息贴上来。

</td>
</tr>
</table>

## 十条规则

完整内容：[简体](skills/adhd-cn/SKILL.md) · [正體](skills/adhd-tw/SKILL.md)

1. 开头就是下一步。
2. 多步骤要编号。
3. 结尾给一个具体的下一步。
4. 压住跑题。
5. 每轮重述当前进度。
6. 时间估计要具体（「15 分钟」，不是「一会儿」）。
7. 让完成的成果看得见。
8. 报错用平实语气。
9. 列表最多 5 项。
10. 不要开场白、不要总结、不要客套结尾。

## 和原版的区别

- 规则全文翻成中文，例句改成中文常见的说法（「好问题！」「希望对你有帮助」）。
- 加了一条「语言」规则：`adhd-cn` 用简体中文回复，`adhd-tw` 用正體中文回复。
- 「关闭 ADHD 模式」「普通模式」都能关闭，英文的 `stop adhd mode` 也还能用。
- 只保留 Claude Code 和 Codex。常驻 hook 改用 `sh`，不需要 Node。

## 自定义

Fork 之后改 `skills/adhd-cn/SKILL.md` 或 `skills/adhd-tw/SKILL.md`，再把 `.claude-plugin/plugin.json` 的 `version` 加一，`claude plugin update` 才会拉到新版。

## 致谢

规则来自 [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)（Ayoub Ghriss），原版参考 J. Russell Ramsay 与 Anthony L. Rostain 的《The Adult ADHD Tool Kit》。

## 许可

[MIT](LICENSE)，保留原作者版权声明。
