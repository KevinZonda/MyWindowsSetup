## APT

```bash
sudo apt install \
    python-is-python3 \
    btop htop neofetch \
    libxrender1 libxfixes3 libxi6 libxkbcommon0 libsm6 libice6 libgl1 libglx-mesa0 \
    build-essential make git
```

```bash
sudo snap install go --classic
sudo snap install node --classic

go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

npm config set registry "https://registry.npmmirror.com"
sudo npm install -g corepack
corepack enable
pnpm config set registry "https://registry.npmmirror.com"
pnpm
```

## Passwordfree Login

```sh
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
#chown -R $USER:$USER ~/.ssh
```

Related SSH config (`sudo nano /etc/ssh/sshd_config`)
```
PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin no
```

## Ubuntu as a Workstation (UaaW)

### Install OpenSSH Server

```
sudo apt update
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

### GNOME Network Manager

Choose 1 of 2:
- 1. Modify GNOME Network Manager to allow specific user group, or
- 2. Use Netplan rather than NetworkManager 

**Option 1:**

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

**Option 2:**

```sh
cd /etc/netplan/
```

Find `.yaml` config file. Modify `renderer: NetworkManager` to `renderer: networkd`.

Then `sudo netplan apply`.

### Disable Automatic Suspend

```sh
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```


### Automatic Upgrade

```
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```


### [Laptop Only] Disable Laptop Lid Close to Sleep

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

### [Laptop Only] Low Battery Shutdown

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

```
*/5 * * * * /bin/bash SCRIPT_PATH
```


