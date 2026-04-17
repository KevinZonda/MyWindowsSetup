# 欺骗 Windows 10 LTSC 21H2 为 22H2

下载 KB5015684：
- x64: <http://b1.download.windowsupdate.com/c/upgr/2022/07/windows10.0-kb5015684-x64_d2721bd1ef215f013063c416233e2343b93ab8c1.cab>
- x86: <http://b1.download.windowsupdate.com/c/upgr/2022/07/windows10.0-kb5015684-x86_3734a3f6f4143b645788cc77154f6288c8054dd5.cab>
- arm64: <http://b1.download.windowsupdate.com/c/upgr/2022/07/windows10.0-kb5015684-arm64_0c61deaba99dfce16b39b53de23173eb7662215b.cab>

解压对应的 CAB 文件，获得 `microsoft-windows-22h2enablement-package~31bf3856ad364e35~amd64~~10.0.19041.1799.mum`

管理员进行：

```
Dism /online /add-package /packagepath:microsoft-windows-22h2enablement-package~31bf3856ad364e35~amd64~~10.0.19041.1799.mum
```

## Credit

Source: https://habr.com/ru/articles/825546/