# macOS Setups

## SDKs

```sh
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# python
brew install pyenv
pyenv install 3.12
pyenv global 3.12
pyenv init --install

# Go & Node & OpenJDK@17
brew install go node openjdk@17

# Codex
brew install --cask codex
brew install --cask codex-app

brew install --cask stats
brew install --cask hot
brew install --cask git-credential-manager
brew install --cask maccy
brew install --cask xquartz
brew install --cask mos

brew install coreutils neovim p7zip git tree gnu-sed wget xz curl btop trash ca-certificates ffmpeg llvm make
```

```
xcode-select --install
xcode-select -p
```

## Apps

- Keka: <https://www.keka.io/en/>
- Magnet: <https://magnet.crowdcafe.com/>
- CotEditor: <https://coteditor.com/>
- BetterDisplay: <https://betterdisplay.pro/>
- Paintbrush: <https://paintbrush.sourceforge.io/>
- Hex Field: <https://hexfiend.com/>
- GrandPerspective: <https://grandperspectiv.sourceforge.net/>
- Bartender: <https://www.macbartender.com/>
- Ubar: <https://ubarapp.com/>

## Hot Corners

```sh
defaults read com.apple.dock | grep wvous # Get HC config
```

```sh
# 左上角：Mission Control
# 右上角：通知中心
# 左下角：Launchpad
# 右下角：显示桌面
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-br-corner -int 4

defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# 重启 Dock 让设置生效
killall Dock

defaults read com.apple.dock | grep wvous
```

清除

```sh
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock

defaults read com.apple.dock | grep wvous
```
