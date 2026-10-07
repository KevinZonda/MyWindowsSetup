# My Pi Settings

`~/.pi/agent/settings.json`:

```json
{
  "lastChangelogVersion": "1.0.4",
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
    "npm:pi-interactive-shell"
  ],
  "compaction": {
    "enabled": true
  },
  "tuiMode": "fullscreen",
  "theme": "cc-dark",
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
