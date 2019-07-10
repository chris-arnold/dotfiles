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


# Homebrew and packages
if has_cmd "brew"; then
    log "Homebrew already installed. Skipping..."
else
    log "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install \
    httpie \
    jq \
    kubernetes-cli \
    ncdu \
    ngrep \
    nmap \
    node \
    par \
    python \
    python@2 \
    the_silver_searcher \
    tig \
    wget \
    yarn \
    zsh


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
$FZF_DOTFILES/install --key-bindings --completion --no-update-rc


# Clone any ZSH plugins.
log "Cloning ZSH plugins."
mkdir -p $ZSH_INCLUDES
$GITCLONE https://github.com/zsh-users/zsh-completions.git $ZSH_INCLUDES/zsh-completions
$GITCLONE https://github.com/zsh-users/zsh-completions.git $ZSH_INCLUDES/zsh-completions
$GITCLONE https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_INCLUDES/zsh-history-substring-search
$GITCLONE https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_INCLUDES/zsh-syntax-highlighting
$GITCLONE https://github.com/rupa/z.git $ZSH_INCLUDES/z
$GITCLONE https://github.com/iam4x/zsh-iterm-touchbar $ZSH_INCLUDES/zsh-iterm-touchbar

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
nvm use default

# goenv
# rbenv


# sdkman
if ! has_cmd "sdk"; then
    echo "sdk command not found, installing SDKMAN"
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi


# java
sdkman install java 12.0.1.j9-adpt


# VSCode
if [ -d "$HOME/Library/Application\ Support/Code" ]; then
    ln -s $DOTFILES/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -s $DOTFILES/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
    ln -s $DOTFILES/vscode/vsicons.settings.json $HOME/Library/Application\ Support/Code/User/vsicons.settings.json
fi


# Neovim
brew install neovim
ln -s $(which nvim) /usr/local/bin/vim
pip3 install neovim
log "Installing vim-plug."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.config/nvim
ln -s $DOTFILES/neovim/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/neovim/syntax $HOME/.config/.nvim/syntax
pip3 install --user neovim python-language-server
pip2 install --user neovim


# Neovim language servers
langserver_dir = "${HOME}/Projects/langserver"
mkdir -p langserver_dir
cd "$langserver_dir"

# Javascript
git clone https://github.com/sourcegraph/javascript-typescript-langserver
cd javascript-typescript-langserver
npm install
npm run build

# Groovy
cd "$langserver_dir"
git clone https://github.com/prominic/groovy-language-server
cd groovy-language-server
./gradlew build

log "NOTE: You'll need to install langservers besides python and js for neovim as needed. See the config file."

# Other Python tools
pip3 install --user \
    bumpversion \
    glances

# Beets - not used for now
# pip3 install --user beets
# ln -s $DOTFILES/beets/config.yaml ~/.config/beets/config.yaml

# Git config
ln -s $HOME/.gitconfig $DOTFILES/.gitconfig
ln -s $HOME/.gitignore_global $DOTFILES/.gitignore_global

