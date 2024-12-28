#!/bin/bash

# Linux Mint Wilma (22)

set -e
mkdir -p $HOME/Code
DOTFILES=$HOME/Code/dotfiles

# Install utilities
echo "Installing apt packages..."
sudo apt-get -y install build-essential git curl zsh vim jq ripgrep fzf fd-find

# Clone dotfiles
if ! [ -d $DOTFILES ]; then
  echo "Cloning dotfiles..."
  git clone git@github.com:tkaretsos/dotfiles $DOTFILES
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

# Install neovim
if ! [ -x "$(command -v nvim)" ]; then
  echo "Installing neovim..."
  asdf plugin add neovim
  asdf install neovim stable
  asdf global neovim stable
else
  echo "neovim already installed..."
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

# Install go
if ! [ -x "$(command -v go)" ]; then
  echo "Installing golang..."
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  asdf install golang latest
  asdf global golang latest
else
  echo "golang already installed"
fi

# Install erlang asdf plugin
if ! asdf plugin list | grep erlang &>/dev/null; then
  echo "Installing erlang asdf plugin..."
  # required packages for erlang
  sudo apt install -y autoconf libssl-dev libncurses-dev

  # rebar is required by Mason NeoVim plugin to install erlang-ls
  if ! [ -x "$(command -v rebar3)"]; then
    echo "Installing rebar3..."
    asdf plugin add rebar https://github.com/Stratus3D/asdf-rebar.git
    asdf install rebar latest
    asdf global rebar latest
  fi

  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  echo "Install the desired erlang/OTP version:"
  echo "$ asdf list all erlang"
  echo "$ asdf install erlang <version>"
  echo "$ asdf global erlang <version>"
else
  echo "erlang asdf plugin already installed"
fi

# Install elixir asdf plugin
if ! asdf plugin list | grep elixir &>/dev/null; then
  echo "Installing elixir asdf plugin..."
  asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
  echo "Install the desired elixir version:"
  echo "$ asdf list all elixir"
  echo "$ asdf install elixir <version>"
  echo "$ asdf global elixir <version>"
else
  echo "elixir asdf plugin already installed"
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
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | cut -c2-)
  echo "Lazygit version = $LAZYGIT_VERSION"
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp
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

echo "Setup finished."
