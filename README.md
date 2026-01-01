# My Windows Setup

## Software

**SDKs:**
- Python 3.12.10: <https://www.python.org/downloads/release/python-31210/>
- Go: <https://go.dev/dl/>
- Git: <https://git-scm.com/install/windows>
- JetBrains ToolBox: <https://www.jetbrains.com/toolbox-app/>
- Nodejs: <https://nodejs.org/en/download>
- MSYS2: <https://www.msys2.org/>
- OpenJDK: <https://learn.microsoft.com/en-gb/java/openjdk/download>

**Utilities:**
- Chrome: <https://www.google.com/intl/en_uk/chrome/>
- TwinkleTray: <https://github.com/xanderfrangos/twinkle-tray/releases/latest>
- QuickLook: <https://github.com/QL-Win/QuickLook/releases/latest>
- Flow Laucher: <https://www.flowlauncher.com/>
- Windows Terminal: <https://github.com/microsoft/terminal/releases/latest>
- Dism++: <https://github.com/Chuyu-Team/Dism-Multi-language/releases/latest>
- WinRAR: <https://www.win-rar.com/download.html>
- WinSCP: <https://winscp.net/eng/download.php>
- LazyCat NAS: <https://lazycat.cloud/download>

**IDEs/Editors:**
- Antigravity: <https://antigravity.google/download>
- VSCode: <https://code.visualstudio.com/download>
- Visual Studio: <https://visualstudio.microsoft.com/downloads/>
- Notepad++: <https://notepad-plus-plus.org/downloads/>

**Agent CLIs:**
- Gemini-CLI: <https://github.com/google-gemini/gemini-cli> or `npm install -g @google/gemini-cli`
- qwen-code: <https://github.com/QwenLM/qwen-code> or `npm install -g @qwen-code/qwen-code@latest`

**Collaboration:**
- Feishu: <https://www.feishu.cn/en/>
- WeChat: <https://windows.weixin.qq.com/> or <https://www.wechat.com/>

**Anti-Virus (Global Plan):**
- Kaspersky (for heavy-load machines): <https://www.kaspersky.com.cn/> (for Chinese activation key) and <https://www.kaspersky.co.uk/> (for British or European activation key)
- ESET (for light-weight machines): <https://www.eset.com/cn/>

**Anti-Virus (China Plan):**
- 360 SafeGuard (for general purpose): <https://weishi.360.cn/>
- 360 SD (for general purpose): <https://sd.360.cn/>
- Huorong (for light-usage): <https://www.huorong.cn/person>

**Fonts:**
- NFs: <https://www.nerdfonts.com/font-downloads>
- OpenSans: <https://fonts.google.com/specimen/Open+Sans>

**Drivers:**
- Intel Thunderbolt Control Center: <https://apps.microsoft.com/detail/9n6f0jv38ph1>  
  (if Microsoft Store doesn't work, use <https://store.rg-adguard.net/>)
## Env

### China Mirror Settings

```
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
```

```pwsh
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

```pwsh
pnpm config set registry "https://registry.npmmirror.com"
npm config set registry "https://registry.npmmirror.com"
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

Puring WPS International
```
WPS_VERSION=12.2.0.23196
USER=Kevin
rm    "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscloudsvr.exe"
rm    "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscloudlaunch.exe"
rm    "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscenter.exe"
mkdir "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscloudsvr.exe"
mkdir "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscloudlaunch.exe"
mkdir "C:\Users\$USER\AppData\Local\Kingsoft\WPS Office\$WPS_VERSION\office6\wpscenter.exe"
```
Or MSYS2
```sh
WPS_VERSION=12.2.0.23196
USER=Kevin
rm    "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscloudsvr.exe"
rm    "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscloudlaunch.exe"
rm    "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscenter.exe"
mkdir "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscloudsvr.exe"
mkdir "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscloudlaunch.exe"
mkdir "/c/Users/$USER/AppData/Local/Kingsoft/WPS Office/$WPS_VERSION/office6/wpscenter.exe"
```

