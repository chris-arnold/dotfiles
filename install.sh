#!/usr/bin/env bash
#
# Intended to be cloned and run, not sourced from github
#
# This assumes zsh is already installed.

# Clone location for this repo - zshrc is symlinked to ~/.zshrc
ZSH_DOTFILES=$HOME/dotfiles/zsh

# Install location for Fuzzy Finder.
FZF_DOTFILES=$HOME/.fzf

# Clone location for ZSH plugins.
ZSH_INCLUDES=$HOME/.local/share/zsh_includes

GITCLONE="git clone --depth=1"

# Start from scratch.
rm -rf \
  $FZF_DOTFILES
  $ZSH_INCLUDES \
  $HOME/.zshrc

ln -s $ZSH_DOTFILES/zshrc $HOME/.zshrc

# Install FZF with key bindings and completion.
$GITCLONE https://github.com/junegunn/fzf.git $FZF_DOTFILES
$DOTFZF/install --key-bindings --completion --no-update-rc

# Clone any ZSH plugins.
mkdir -p $ZSH_INCLUDES
$GITCLONE https://github.com/zsh-users/zsh-completions.git $ZSH_INCLUDES/zsh-completions
$GITCLONE https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_INCLUDES/zsh-history-substring-search
$GITCLONE https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_INCLUDES/zsh-syntax-highlighting
$GITCLONE https://github.com/rupa/z.git $ZSH_INCLUDES/z
if [ ! -f "$HOME/.z" ]; then
  touch $HOME/.z
fi

cd $HOME
rm -f $HOME/.zcompdump*

# NVM
if [ -d "$HOME/.nvm" ]; then
  $GITCLONE https://github.com/creationix/nvm.git $HOME/.nvm
fi

# GVM - Disabled for now.
# if ! command -v gvm; then
#   zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
# fi

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

