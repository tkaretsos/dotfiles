#!/bin/bash

set -e
cd $HOME
CODE_DIR=$HOME/Code
mkdir -p $CODE_DIR

# Install utilities
echo "Installing apt packages..."
sudo apt-get -y -qq install build-essential git curl zsh vim jq ripgrep

echo

# Clone dotfiles
if ! [ -d $CODE_DIR/dotfiles ]; then
  echo "Cloning dotfiles..."
  git clone git@github.com:tkaretsos/dotfiles $CODE_DIR/dotfiles
  echo
  echo "Setting up configuration files..."
  ln -s $CODE_DIR/dotfiles/.vimrc $HOME/.vimrc
  ln -s $CODE_DIR/dotfiles/.vim $HOME/.vim
  cp $CODE_DIR/dotfiles/.gitconfig $HOME
fi

# Install asdf
if ! [ -d $HOME/.asdf ]; then
  echo "Installing asdf..."
  ASDF_LATEST=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/tags" | jq -r '.[0].name')
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_LATEST
else
  echo "asdf already installed"
fi

echo

# Install ulauncher
if ! [ -x "$(command -v ulauncher)" ]; then
  echo "Installing ulauncher..."
  sudo add-apt-repository -y ppa:agornostal/ulauncher
  sudo apt update
  sudo apt-get -y install ulauncher
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
  ln -s $CODE_DIR/dotfiles/.zshrc $HOME/.zshrc

  echo "Log out and log in required"
else
  echo "oh-my-zsh already installed"
fi
