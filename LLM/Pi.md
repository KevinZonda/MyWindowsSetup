# My Pi Settings

`~/.pi/agent/settings.json`:

```json
{
  "defaultProvider": "openai",
  "defaultModel": "gpt-6.1-sol",
  "packages": [
    "npm:pi-web-access",
    "npm:pi-subagents",
    "npm:@juicesharp/rpiv-ask-user-question",
    "npm:@juicesharp/rpiv-todo",
    "npm:pi-goal-x",
    "npm:@companion-ai/feynman",
    "npm:pi-lens",
    "npm:@dietrichgebert/ponytail",
    "npm:pi-cc-extensions",
    "npm:@narumitw/pi-btw",
    "npm:pi-interactive-shell",
    "npm:pi-tab-title",
    "npm:@gotgenes/pi-permission-system",
    "npm:cc-safety-net"
  ],
  "compaction": {
    "enabled": true
  },
  "tuiMode": "fullscreen",
  "theme": "claude-dark",
  "terminal": {
    "showTerminalProgress": true
  },
  "enableInstallTelemetry": false,
  "quietStartup": true
}
```

## Others

`~/.pi-lens/config.json`:
```json
{
  "ui": {
    "hideLspStatus": true
  },
  "widget": {
    "visible": false
  }
}
```

`~/.config/ponytail/config.json`:
```json
{
  "defaultMode": "full",
  "hideStatus": true
}
```

## Theme

```sh
mkdir -p ~/.pi/agent/themes
curl -L https://raw.githubusercontent.com/minuque/pi-cc-extensions/main/themes/cc-dark.json \
  -o ~/.pi/agent/themes/claude-dark.json
```

```
nano ~/.pi/agent/themes/claude-dark.json
```

replace

```
	"vars": {
		"bg": "#1f1f1f",
		"panel": "#252525",
		"surface": "#2b2b2b",
		"surfaceRaised": "#333333",
		"border": "#444444",
		"borderMuted": "#292631",
		"accent": "#D97757",
		"accentBright": "#E99578",
		"purple": "#c084fc",
		"pink": "#f472b6",
		"cyan": "#67e8f9",
		"blue": "#60a5fa",
		"green": "#4ade80",
		"red": "#fb7185",
		"yellow": "#facc15",
		"orange": "#fb923c",
		"text": "#f5f5f5",
		"muted": "#a1a1aa",
		"dim": "#71717a",
		"selectedBg": "#252035",
		"userMessageBg": "#373737",
		"toolPendingBg": "#252525",
		"toolSuccessBg": "#252525",
		"toolErrorBg": "#382528",
		"customMessageBg": "#2b2b2b"
	},
```


`"name": "cc-dark"` to `"name": "claude-dark"`

## Permission `@gotgenes/pi-permission-system`

`~/.pi/agent/extensions/pi-permission-system/config.json`:
```json
{
  "permission": {
    "*": "allow",
    "path": {
      "*": "allow",
      "*.env": "deny",
      "*.env.*": "deny",
      "*.env.example": "allow"
    },
    "bash": {
      "*": "ask",
      "rm -rf *": "deny",
      "sudo *": "ask"
    },
    "external_directory": "ask"
  }
}
```
