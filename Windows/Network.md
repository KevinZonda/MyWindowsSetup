# Network & Bluetooth Troubleshooting

## Reset Network Commands

Reset network stack:
```bat
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
```

Windows 网络组件重装命令：

```bat
netcfg -d
```

## WLAN cannot found APs

Check whether `WLAN AutoConfig` Service is running.