# My Pi Settings

`~/.pi/agent/settings.json`:

```json
{
  "lastChangelogVersion": "1.1.0",
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
    "npm:@narumitw/pi-btw",
    "npm:pi-interactive-shell",
    "npm:pi-tab-title",
    "npm:@gotgenes/pi-permission-system",
    "npm:cc-safety-net",
    "npm:pi-context-view",
    "npm:@quintinshaw/pi-dynamic-workflows",
    "npm:pi-cc-extensions",
    "git:github.com/KevinZonda/pi-cc-extension-patches",
    "npm:@narumitw/pi-codex-compact",
    "git:github.com/KevinZonda/pi-enhance-patches",
    "npm:pi-background-tasks",
    "npm:@narumitw/pi-usage"
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
  "quietStartup": true,
  "steeringMode": "one-at-a-time",
  "enabledModels": [
    "openai-codex/gpt-6.1-sol",
    "openai-codex/gpt-6-astra",
    "openai-codex/gpt-5.6-sol"
  ]
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
