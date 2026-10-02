# Uninstall VPN Services in macOS

## aTrust

Refer: <https://deusyu.app/posts/atrust-uninstall/>

## F5

Refer: <https://my.f5.com/manage/s/article/K43645319>

## ZScaler

```
#!/bin/sh
## ZScaler Uninstaller
## Via https://community.jamf.com/general-discussions-2/uninstall-zscaler-20819

# Stop Service
sudo launchctl unload /Library/LaunchDaemons/com.zscaler.service.plist
sudo killall Zscaler

# Remove Application Files
sudo rm -rf /Applications/Zscaler

# Remove Launch Agent
sudo rm -rf /Library/LaunchAgents/com.zscaler.tray.plist

# Remove Launch Daemons
sudo rm -rf /Library/LaunchDaemons/com.zscaler.service.plist
sudo rm -rf /Library/LaunchDaemons/com.zscaler.tunnel.plist

# Remove root PLIST
sudo rm -rf /private/var/root/Library/Preferences/ZscalerService.plist
```
