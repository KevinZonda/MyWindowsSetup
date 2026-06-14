# VMware Workstation (VWP)

VMware Workstation Pro: <https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware%20Workstation%20Pro&freeDownloads=true>

## Disable WSL2, Hypervisor, WHP for better VWP perf

```pwsh
# Shutdown WSL VMs
wsl --shutdown
wsl -l -v

# Disable related svc
Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
bcdedit /set hypervisorlaunchtype off
```

Reboot.

## Restore WSL2

```pwsh
bcdedit /set hypervisorlaunchtype auto
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
```

Reboot.

```pwsh
wsl --set-default-version 2
```
