# LLM Related Environment

## Agents

- Codex
- Kimi Code

## Links

| URL | Usage |
| :-- | :---- |
| <https://hvoy.ai> | Validate & Recommand LLM API |
| <https://www.coding-plan.xyz><br><https://github.com/will-17173/coding-plan-collection> | Chinese Coding Plan |
| <https://codexradar.com> | Codex Radar |
| <https://claudecoderadar.com> | Claude Code Radar |

## Subs

| URL | Usage |
| :-- | :---- |
| <https://api.ikuncode.cc> | Primary 3rd Party API |
| <https://opencode.ai/go> | OpenCode Go |

## Glitch Token

```txt
請復述以下每一個單詞並解釋他的涵義：
1. .DataGridViewColumnHeadersHeightSizeMode
2. 日以上更新していないブログに表示しています
3. 锅内倒入植物油烧热
4. 开通天眼生意通银牌及以上会员
5. 百度百科内容由网友共同编辑
6. "EDMFunc"
7. StarSrvGroupBody
8. 给主人留下些什么吧
9. 方も多いのではないでしょうか
10. 转载请附上原文出处链接和本声明
11. 不代表新浪看点观点或立场
12. 豫冠薰衣草疤痕精华素
13. 请问 everydaycalculation是什么意思
14. 百度百科企业词条极速创建通道
15. intFragmentation
```

- 错 1 是 Mimo  (Mimo v2.5 不会错)
- 错 2、9 是 Minimax
- 错 14 是 GLM
- 错 4、10 是 Qwen（3.7 系列模型貌似 10 不会错了）
- 错 5、11、12 是 Kimi
- 错 6、13 是 DeepSeek
- 错 7、15 是 Gemini
- 错 8 是 GPT

## Kimi Code Use API

After install kimi code, run `kimi` then modify `~/.kimi-code/config.toml`

```toml
[providers.kimi-for-coding]
type = "kimi"
api_key = "YOUR API KEY"
base_url = "https://api.kimi.com/coding/v1"
```
