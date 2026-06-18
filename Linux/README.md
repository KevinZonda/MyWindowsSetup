# Linux Setups

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

```txt
PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin no
```

## BBR & Swapiness

```sh
sudo nano /etc/sysctl.conf
```

```ini
# Decrease Swap usage
# Validate via cat /proc/sys/vm/swappiness
vm.swappiness=10

# Enable BBR
# Prereq: uname -r # >4.9
# Validate via
#     -> sysctl net.ipv4.tcp_congestion_control
#     -> lsmod | grep bbr
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
```

```sh
sudo sysctl -p
```
