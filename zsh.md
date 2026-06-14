# zsh Configuation

```sh
pacman -S zsh
zsh
```

## Install On-My-ZSH

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Open `~/.zshrc`, modify  `plugins=(git)` to

```sh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

THEME:

```sh
ZSH_THEME="ys"
```

## Fix Paste Mode

For example, `[200~`.

```sh
echo "unset zle_bracketed_paste" >> ~/.zshrc
source ~/.zshrc
```

Or it may caused by oh-my-pos

```sh
echo 'DISABLE_MAGIC_FUNCTIONS="true"' >> ~/.zshrc
source ~/.zshrc
```
