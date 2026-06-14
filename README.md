# My Windows Setup

## Software

**SDKs:**
- Python 3.12.10: <https://www.python.org/downloads/release/python-31210/>  
  <https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe>
- Go: <https://go.dev/dl/>
- Git: <https://git-scm.com/install/windows>
- JetBrains ToolBox: <https://www.jetbrains.com/toolbox-app/>
- Nodejs: <https://nodejs.org/en/download>
- MSYS2: <https://www.msys2.org/>
- OpenJDK: <https://learn.microsoft.com/en-gb/java/openjdk/download>
- CUDA Tookit:
  - 12.8 (Ampere): <https://developer.nvidia.com/cuda-12-8-0-download-archive>
  - 11.7 (Volta/Pascal): <https://developer.nvidia.com/cuda-11-7-0-download-archive>
- Build Tools for Visual Studio: <https://visualstudio.microsoft.com/downloads/?q=build+tools>
- CMake: <https://cmake.org/download/>

**Utilities:**
- Chrome: <https://www.google.com/intl/en_uk/chrome/>
- TwinkleTray: <https://github.com/xanderfrangos/twinkle-tray/releases/latest>
- QuickLook: <https://github.com/QL-Win/QuickLook/releases/latest>
- Flow Laucher: <https://www.flowlauncher.com/>
- Windows Terminal: <https://github.com/microsoft/terminal/releases/latest> or <https://apps.microsoft.com/detail/9n0dx20hk701>
- Dism++: <https://github.com/Chuyu-Team/Dism-Multi-language/releases/latest>
- WinRAR: <https://www.win-rar.com/download.html>
- WinSCP: <https://winscp.net/eng/download.php>
- LazyCat NAS: <https://lazycat.cloud/download>

**Terminal:**
- Windows Terminal: <https://apps.microsoft.com/detail/9n0dx20hk701?hl=en-GB&gl=GB>
- ~~Warp: <https://www.warp.dev>~~

**IDEs/Editors:**
- Cursor: <https://cursor.com/download>
- VSCode: <https://code.visualstudio.com/download>
- Antigravity: <https://antigravity.google/download>
- Visual Studio: <https://visualstudio.microsoft.com/downloads/>
- Notepad++: <https://notepad-plus-plus.org/downloads/>

**Agent CLIs:**
- OpenAI Codex: `npm i -g @openai/codex`
- Claude Code: <https://claude.com/download> or `npm install -g @anthropic-ai/claude-code-win32-x64` or `npm install -g @anthropic-ai/claude-code`
- OpenCode: `npm i -g opencode-ai`
- ~~Gemini-CLI: <https://github.com/google-gemini/gemini-cli> or `npm install -g @google/gemini-cli`~~
- ~~qwen-code: <https://github.com/QwenLM/qwen-code> or `npm install -g @qwen-code/qwen-code@latest`~~

**Collaboration:**
- Feishu: <https://www.feishu.cn/en/>
- WeChat: <https://windows.weixin.qq.com/> or <https://www.wechat.com/>


**Anti-Virus:**
- for Global Region:
  - Kaspersky (for heavy-load machines): <https://www.kaspersky.com.cn/> (for Chinese activation key) and <https://www.kaspersky.co.uk/> (for British or European activation key)
  - ESET (for light-weight machines): <https://www.eset.com/cn/>
- for Mainland, China Region:
  - 360 SafeGuard (for general purpose): <https://weishi.360.cn/>
  - 360 SD (for general purpose): <https://sd.360.cn/>
  - Huorong (for light-usage): <https://www.huorong.cn/person>

**Fonts:**
- NFs: <https://www.nerdfonts.com/font-downloads>
- OpenSans: <https://fonts.google.com/specimen/Open+Sans>

**Work:**
- Office-Tool: <https://github.com/yerongai/office-tool>
- DISM++: <https://github.com/Chuyu-Team/Dism-Multi-language>

**Drivers:**
- Intel Thunderbolt Control Center: <https://apps.microsoft.com/detail/9n6f0jv38ph1>  
  (if Microsoft Store doesn't work, use <https://store.rg-adguard.net/>)

## Env

### SDKs Activation

```cmd
; Use administrator mode
corepack enable
```

```sh
pip isntall --upgrade pip
pip install torch numpy matplotlib pandas lightning opencv-python scikit-learn scikit-image scipy seaborn
```

```sh
# MSYS2 UCRT
pacman -Sy
pacman -S make mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-clang winpty zsh
```

Append MSYS2 to system environment (`PATH` of User's setting)

```
C:\msys64\usr\bin
C:\msys64\ucrt64\bin
```

### Windows Modification

- Enable mDNS

```cmd
REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /V "EnableMulticast" /D "0" /T REG_DWORD /F
```

- Enable Windows 10 ESU
- Make explorer's file extension be visible

### Software Modification

#### Terminal

Fix PowerShell cannot input Chinese:

```pwsh
Install-Module PSReadLine -Scope CurrentUser -Force # -SkipPublisherCheck
```

Use following reg to add terminal to context menu

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\WindowsTerminal\command]
@="wt.exe -d \"%V\""

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\WindowsTerminal\command]
@="wt.exe -d \"%1\""

[HKEY_CURRENT_USER\Software\Classes\Drive\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Drive\shell\WindowsTerminal\command]
@="wt.exe -d \"%1\""
```

If you know where is wt, do:

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe\\wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\WindowsTerminal\command]
@="wt.exe -d \"%V\""

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe\\wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\WindowsTerminal\command]
@="wt.exe -d \"%1\""

[HKEY_CURRENT_USER\Software\Classes\Drive\shell\WindowsTerminal]
@="Open in Windows Terminal"
"Icon"="C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe\\wt.exe"

[HKEY_CURRENT_USER\Software\Classes\Drive\shell\WindowsTerminal\command]
@="wt.exe -d \"%1\""
```

## GB Layout Keyboard

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000804]
"Layout File"="KBDUK.DLL"
"Layout Text"="Chinese (Simplified) - GB Keyboard"
```
