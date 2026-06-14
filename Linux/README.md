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
