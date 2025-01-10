#!/bin/bash

# Linux Mint Wilma (22)

set -e
mkdir -p $HOME/Code
DOTFILES=$HOME/Code/dotfiles
MISE=$HOME/.local/bin/mise

# Install utilities
echo "Installing apt packages..."
sudo apt-get -y install build-essential curl wget gpg git zsh vim jq ripgrep fzf fd-find xclip inotify-tools

# Clone dotfiles
if ! [ -d $DOTFILES ]; then
  echo "Cloning dotfiles..."
  git clone git@github.com:tkaretsos/dotfiles $DOTFILES
  echo "Setting up configuration files..."
  ln -s $DOTFILES/.vimrc $HOME/.vimrc
  ln -s $DOTFILES/.vim $HOME/.vim
  cp $DOTFILES/.gitconfig $HOME
fi

if ! [ -f $MISE ]; then
  echo "installing mise..."
  curl https://mise.jdx.dev/mise-latest-linux-x64 >$MISE
  chmod +x $MISE
  # enable autocompletion
  $MISE use -g usage
  mkdir -p /usr/local/share/zsh/site-functions
  $MISE completion zsh | sudo tee /usr/local/share/zsh/site-functions/_mise &>/dev/null
else
  echo "mise already installed..."
fi

if ! [ -x "$(command -v nvim)" ]; then
  echo "installing neovim..."
  $MISE use -g neovim
  git clone git@github.com:tkaretsos/neovim-config.git $HOME/.config/nvim
else
  echo "neovim already installed..."
fi

# Install Nerd font
if ! [ -d $HOME/.local/share/fonts/DejaVuSansMNerdFont ]; then
  echo "Installing nerd font..."
  mkdir -p $HOME/.local/share/fonts
  DEJAVU_VERSION=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | jq -r '.tag_name' | cut -c2-)
  wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v${DEJAVU_VERSION}/DejaVuSansMono.zip
  unzip /tmp/DejaVuSansMono.zip -d $HOME/.local/share/fonts/DejaVuSansMNerdFont
  fc-cache -fv
else
  echo "nerd font already installed"
fi

# Install Lazygit
if ! [ -x "$(command -v lazygit)" ]; then
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | cut -c2-)
  echo "Lazygit version = $LAZYGIT_VERSION"
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp
  sudo install /tmp/lazygit -D -t /usr/local/bin/
else
  echo "lazygit already installed"
fi

# Install oh-my-zsh
if ! [ -d $HOME/.oh-my-zsh ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

  rm $HOME/.zshrc
  ln -s $DOTFILES/.zshrc $HOME/.zshrc

  echo "Log out and log in required"
else
  echo "oh-my-zsh already installed"
fi

echo "Setup finished."
