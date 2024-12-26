#!/bin/bash

set -e
cd $HOME
mkdir -p $HOME/Code

# Install utilities
echo "Installing apt packages..."
sudo apt-get -y -qq install build-essential git curl zsh vim jq ripgrep

echo

DOTFILES=$HOME/Code/dotfiles

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
  ASDF_LATEST=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/tags" | jq -r '.[0].name')
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_LATEST
  if [ -f $DOTFILES/.tool-versions ]; then
    cp $DOTFILES/.tool-versions $HOME
  fi
else
  echo "asdf already installed"
fi

# Install neovim
if ! [ -x "$(command -v nvim)" ]; then
  echo "Installing neovim..."
  asdf plugin add neovim
  asdf install neovim stable
  asdf global neovim stable
else
  echo "neovim already installed"
fi

echo

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

echo

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
