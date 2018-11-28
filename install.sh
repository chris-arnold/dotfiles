#!/usr/bin/env bash
#
# Intended to be cloned and run, not sourced from github
#
# This assumes zsh is already installed.

function log {
    echo "$(date) * $1"
}

function has_cmd {
    command -v "$1" >/dev/null 2>&1
}

function has_brew_pkg {
    if brew ls --versions "$1"; then
        return 0
    else
        return 1
    fi
}

# VARS
# Clone location for this repo - zshrc is symlinked to ~/.zshrc
DOTFILES=$HOME/dotfiles
ZSH_DOTFILES=$DOTFILES/zsh

# Install location for Fuzzy Finder.
FZF_DOTFILES=$HOME/.fzf

# Clone location for ZSH plugins.
ZSH_INCLUDES=$HOME/.local/share/zsh_includes

GITCLONE="git clone --depth=1"

VSCODE_SETTINGS="$HOME/Library/Application\ Support/Code/User/"


# Homebrew
if has_cmd "brew"; then
    log "Homebrew already installed. Skipping..."
else
    log "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install neovim tig httpie jq cmus ngrep nmap ncdu node yarn par wget zsh


# Start from scratch.
log "Removing existing config directories."
rm -rf \
    $FZF_DOTFILES
    $ZSH_INCLUDES \
    $HOME/.zshrc
    $VSCODE_SETTINGS

ln -s $ZSH_DOTFILES/zshrc $HOME/.zshrc


# Install FZF with key bindings and completion.
log "Installing FZF and bindings."
$GITCLONE https://github.com/junegunn/fzf.git $FZF_DOTFILES
$DOTFZF/install --key-bindings --completion --no-update-rc


# Clone any ZSH plugins.
log "Cloning ZSH plugins."
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
log "Installing NVM."
if [ -d "$HOME/.nvm" ]; then
    $GITCLONE https://github.com/creationix/nvm.git $HOME/.nvm
fi


# GVM - Disabled for now.
# if ! command -v gvm; then
#   zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
# fi


# VSCode
cp $DOTFILES/vscode/* $HOME/Library/Application\ Support/Code/User/


# Neovim
log "Installing vim-plug."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
log "NOTE: You'll need to install langservers for neovim as needed. See the config file."

