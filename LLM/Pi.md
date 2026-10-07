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
"accent": "#5e9cff",
"accentBright": "#8ab4ff"
```

to
```
"accent": "#D97757",
"accentBright": "#E99578"
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
