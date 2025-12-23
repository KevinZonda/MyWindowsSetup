# My Windows Setup

## Software

SDKs:
- Python 3.12.10: <https://www.python.org/downloads/release/python-31210/>
- Go: <https://go.dev/dl/>
- Git: <https://git-scm.com/install/windows>
- JetBrains ToolBox: <https://www.jetbrains.com/toolbox-app/>
- Nodejs: <https://nodejs.org/en/download>
- MSYS2: <https://www.msys2.org/>

Utilities:
- TwinkleTray: <https://github.com/xanderfrangos/twinkle-tray/releases/latest>
- QuickLook: <https://github.com/QL-Win/QuickLook/releases/latest>
- Flow Laucher: <https://www.flowlauncher.com/>
- Windows Terminal: <https://github.com/microsoft/terminal/releases/latest>
- Dism++: <https://github.com/Chuyu-Team/Dism-Multi-language/releases/latest>

IDEs/Editors:
- Antigravity: <https://antigravity.google/download>
- VSCode: <https://code.visualstudio.com/download>
- Visual Studio: <https://visualstudio.microsoft.com/downloads/>
- Notepad++: <https://notepad-plus-plus.org/downloads/>

## Env

### China Mirror Settings
```
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
```

```pwsh
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

### SDKs Activation

```cmd
; Use administrator mode
corepack enable
```

```
pip isntall --upgrade pip
pip install torch numpy matplotlib pandas lightning opencv-python scikit-learn scikit-image scipy seaborn
```

### Windows Modification

Enable mDNS

```cmd
REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /V "EnableMulticast" /D "0" /T REG_DWORD /F
```
