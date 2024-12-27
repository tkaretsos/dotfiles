#!/bin/bash

# Linux Mint Wilma (22)

set -e
cd $HOME
mkdir -p $HOME/Code
DOTFILES=$HOME/Code/dotfiles

# Install utilities
echo "Installing apt packages..."
sudo apt-get -y -qq install build-essential git curl zsh vim jq ripgrep fzf fd-find neovim

# Clone dotfiles
if ! [ -d $DOTFILES ]; then
  echo "Cloning dotfiles..."
  git clone git@github.com:tkaretsos/dotfiles $DOTFILES
  echo
  echo "Setting up configuration files..."
  ln -s $DOTFILES/.vimrc $HOME/.vimrc
  ln -s $DOTFILES/.vim $HOME/.vim
  cp $DOTFILES/.gitconfig $HOME
fi

# Install asdf
if ! [ -d $HOME/.asdf ]; then
  echo "Installing asdf..."
  ASDF_VERSION=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/tags" | jq -r '.[0].name')
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_VERSION
  if [ -f $DOTFILES/.tool-versions ]; then
    cp $DOTFILES/.tool-versions $HOME
  fi
else
  echo "asdf already installed"
fi

# Install npm
if ! [ -x "$(command -v npm)" ]; then
  echo "Installing NodeJS..."
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest
  asdf global nodejs latest
else
  echo "NodeJS already installed"
fi

# Install Nerd font
if ! [ -d $HOME/.local/share/fonts/DejaVuSansMNerdFont ]; then
  echo "Installing nerd font..."
  mkdir -p $HOME/.local/share/fonts
  wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip
  unzip /tmp/DejaVuSansMono.zip -d $HOME/.local/share/fonts/DejaVuSansMNerdFont
  fc-cache -fv
else
  echo "nerd font already installed"
fi

# Install Lazygit
if ! [ -x "$(command -v lazygit)" ]; then
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz /tmp/lazygit
  sudo install /tmp/lazygit -D -t /usr/local/bin/
else
  echo "lazygit already installed"
fi

# Install ulauncher
if ! [ -x "$(command -v ulauncher)" ]; then
  echo "Installing ulauncher..."
  sudo add-apt-repository -y ppa:agornostal/ulauncher
  sudo apt update
  sudo apt-get -y install ulauncher
  rm $HOME/.config/ulauncher/settings.json
  ln -s $DOTFILES/.config/ulauncher/settings.json $HOME/.config/ulauncher/settings.json
else
  echo "ulauncher already installed"
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

echo "Setup finished. Reboot is required."
