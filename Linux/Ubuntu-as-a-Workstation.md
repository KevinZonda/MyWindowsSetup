# Ubuntu as a Workstation (UaaW)

## Core Packages

### Install OpenSSH Server

```sh
sudo apt update
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

### GNOME Network Manager

GNM will popup leads to network break. Choose 1 of 2.

**Option 1:** Modify GNOME Network Manager to allow specific user group

```sh
sudo nano /etc/polkit-1/rules.d/10-network-manager.rules
```

```js
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 &&
        subject.isInGroup("sudo")) {
        return polkit.Result.YES;
    }
});
```

**Option 2:** Use Netplan replacing NetworkManager

```sh
cd /etc/netplan/
```

Find `.yaml` config file. Modify `renderer: NetworkManager` to `renderer: networkd`.

Then `sudo netplan apply`.

## System Modification

Disable Automatic Suspend

```sh
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

Automatic Upgrade

```sh
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

## [Laptop Only] Disable Laptop Lid Close to Sleep

```sh
sudo nano /etc/systemd/logind.conf
```

Modify from

```sh
#HandleLidSwitch=suspend
#HandleLidSwitchExternalPower=suspend
#HandleLidSwitchDocked=xxx
```

to

```sh
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

Then

```sh
sudo systemctl restart systemd-logind
```

## [Laptop Only] Low Battery Shutdown

Create a script:

```sh
THRESHOLD=20

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)
if [ "$STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" -le $THRESHOLD ]; then
    echo "Low batter, shutting down..."
    shutdown -h now
fi
```

Create crontab by `sudo crontab -e`, appemd

```sh
*/5 * * * * /bin/bash SCRIPT_PATH
```
