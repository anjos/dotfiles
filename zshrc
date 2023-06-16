#!/usr/bin/env zsh
# Andre Anjos <andre.dos.anjos@gmail.com>
# 2022-03-02 15:38

# Initialization for **interactive** shells

# Default path setup
# Update values at /etc/paths and /etc/manpaths
eval `/usr/libexec/path_helper`

# Adds homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Conda setup
if [ -f ${HOME}/mamba/etc/profile.d/conda.sh ]; then
  source ${HOME}/mamba/etc/profile.d/conda.sh
  export OSX_SDK_DIR="/opt"
  export CONDA_BUILD_SYSROOT="${OSX_SDK_DIR}/MacOSX11.0.sdk"
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Removes duplicates from PATH
export PATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH);

# Path to your oh-my-zsh installation.
export ZSH="/Users/andre/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${HOME}/.dotfiles/config/zsh"

# Configuration for fzf
# Recommended to install: fzf fd ripgrep bat git-delta
export FZF_DEFAULT_COMMAND="fd --hidden --color=always --follow --exclude '*~' --exclude '.git'"
export FZF_DEFAULT_OPTS="--height 50% --border --ansi"
alias fzpv="${FZF_DEFAULT_COMMAND} --type f | fzf --preview 'bat --style=plain --color=always --line-range :100 {}'"

# Use fd instead of the default find command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --color=always --hidden --follow --exclude '*~' --exclude '.git' . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --color=always --hidden --follow --exclude '*~' --exclude '.git' . "$1"
}

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()
plugins+=(conda-zsh-completion)
plugins+=(gitfast)
plugins+=(python)
plugins+=(themes)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(history-substring-search)
plugins+=(fzf)

source $ZSH/oh-my-zsh.sh

# Starship shell
eval "$(starship init zsh)"

# User configuration

# Opens file with vim upon ctrl-t (fzf)
fzf_editor() {
  local file=$(fzpv)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-vi} "$file"
  fi
}
bindkey -s '^t' 'fzf_editor\n'

# for conda auto-completion
autoload -U compinit && compinit

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX users)
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Standard aliases
alias h='history'
if type "vivid" > /dev/null; then
  export LS_COLORS=$(vivid generate snazzy)
fi
if type "lsd" > /dev/null; then
  alias ls='lsd --hyperlink=auto'
elif type "gls" > /dev/null; then
  alias ls='gls'
elif type "exa" > /dev/null; then
  alias ls='exa --git --classify --header --sort=modified'
fi
alias ll='ls --long'
alias la='ls --all'
alias lla='ll --all'
alias lt='ls --tree'
alias rm='rm -vi'
if type "grm" > /dev/null; then
  alias rm='grm -vi'
fi
alias cp='cp -vi'
if type "gcp" > /dev/null; then
  alias cp='gcp -vi'
fi
alias mv='mv -vi'
if type "gmv" > /dev/null; then
  alias mv='gmv -vi'
fi
if type "gchmod" > /dev/null; then
  alias chmod='gchmod -c'
  alias chown='gchown -c'
  alias chgrp='gchgrp -c'
fi
alias grep='grep --color'
if type "nvim" > /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi
alias t='tmux'
alias tl='tmux ls'
alias tn='tmux new-session -A -s'
alias tc='tmux capture-pane -pt'
alias it='ssh -t idiap tmux'
alias itn='it new-session -A -s'
alias itc='it capture-pane -pt'
alias itl='it ls'
if type "bat" > /dev/null; then
  alias cat='bat --style=plain'
fi

alias os='open -a Skim'
alias pipdev='pip install --no-build-isolation --no-dependencies --editable'

# Programs controlled by environment variables
export EDITOR=nvim;
export VISUAL=nvim;
export PAGER=less;

# A function to start a new tunnel to my machine at Idiap
function rdmac () {
  if [[ $1 == "-h" ]]; then
    echo "Enables a remote desktop to an idiap mac ci:"
    echo "$ rdmac"
    echo "$ rdmac <num>"
    echo "$ rdmac <num> <port>"
    echo ""
    echo "# <num>:"
    echo "#   1 - mac pro"
    echo "#   2 - old mac mini"
    echo "#   3 - m1 mac mini"
    echo "#   default = 1"
    echo ""
    echo "# <port> is the local port to bind to (default 5900)"
    return 1
  fi
  local target="bsp-ws02"
  local port="5900"
  if [[ $# -ge 1 ]]; then
      if [[ $1 == 1 ]]; then
          local target="bsp-ws02"
      elif [[ $1 == 2 ]]; then
          local target="beatmacosx01"
      elif [[ $1 == 3 ]]; then
          local target="beatmacosx02"
      else
          echo "choose <num> to be 1, 2 or 3"
          return
      fi
  fi
  if [[ $# == 2 ]]; then
      local port=$2
  fi
  cmd="ssh -N -L ${port}:${target}.lab.idiap.ch:5900 idiap"
  echo "tunnel: $cmd"
  eval $cmd
}

# This starts a VPN tunnel to Idiap
function vpn() {
    sudo openfortivpn sslvpn.idiap.ch:443 --username=aanjos --trusted-cert 36e9b7ab8fac6699da2f617a58b4fb32e140a62352bcde30569d6a5ea09d0b4e --pppd-use-peerdns=1
}

# Sets up the core dump limits
ulimit -c 0;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# Integration with iTerm2 and Kitty
if [[ -n $ITERM_SESSION_ID && -r "${ZSH_CUSTOM}/iterm2_shell_integration.zsh" ]]; then
    source "${ZSH_CUSTOM}/iterm2_shell_integration.zsh"
elif [[ -n $KITTY_INSTALLATION_DIR ]]; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
    alias ssh="kitty +kitten ssh"
    function svim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=window --location=before
    }
    function xvim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=os-window
    }
    alias gvim=xvim
fi

# Integrates direnv
if ! command -v direnv &> /dev/null
then
    echo "direnv not installed - disabling zsh extensions"
else
    eval "$(direnv hook zsh)"
fi

# Updates the current brew/pip/neovim/mamba/conda/omz installations
function update_homebrew {
    local brew=$HOMEBREW_PREFIX/bin/brew

    kegs=()
    kegs+=('bat')
    kegs+=('coreutils')
    kegs+=('curl')
    kegs+=('direnv')
    #kegs+=('exa')
    kegs+=('fd')
    kegs+=('findutils')
    kegs+=('fzf')
    kegs+=('git')
    kegs+=('git-delta')
    kegs+=('git-filter-repo')
    kegs+=('git-lfs')
    kegs+=('gnu-sed')
    kegs+=('graphviz')
    kegs+=('grep')
    kegs+=('htop')
    kegs+=('imagemagick')
    kegs+=('latexdiff')
    kegs+=('latexindent')
    kegs+=('libyaml')
    kegs+=('neovim')
    kegs+=('openfortivpn')
    kegs+=('pass')
    kegs+=('pyinvoke')
    kegs+=('python@3.9')
    kegs+=('python@3.10')
    kegs+=('ripgrep')
    kegs+=('starship')
    kegs+=('texlab')
    kegs+=('tree-sitter')
    kegs+=('tmux')
    kegs+=('vivid')
    kegs+=('wget')
    kegs+=('zsh')

    #echo "[upenv] Installing required homebrew kegs (packages)..."
    #${brew} install "${kegs[@]}"

    taps=()
    taps+=('homebrew/cask-fonts')

    #echo "[upenv] Tapping required homebrew sources (taps)..."
    #${brew} tap homebrew/cask-fonts

    casks=()
    casks+=('balenaetcher')
    casks+=('font-inconsolata-nerd-font')
    casks+=('font-jetbrains-mono-nerd-font')
    casks+=('font-lekton-nerd-font')
    casks+=('font-meslo-lg-nerd-font')
    casks+=('font-roboto-mono-nerd-font')
    casks+=('font-sauce-code-pro-nerd-font')
    casks+=('font-ubuntu-mono-nerd-font')
    casks+=('hammerspoon')
    casks+=('inkscape')
    casks+=('kitty')
    casks+=('mactex')
    casks+=('mattermost')
    casks+=('qlmarkdown')
    casks+=('skim')
    casks+=('syntax-highlight')
    casks+=('timemachineeditor')
    casks+=('xquartz')

    #echo "[upenv] Installing required homebrew casks..."
    #${brew} install --cask "${casks[@]}"

    echo "[upenv] Updating homebrew..."
    ${brew} update

    echo "[upenv] Upgrading homebrew packages..."
    ${brew} upgrade

    echo "[upenv] Updating homebrew casks..."
    ${brew} upgrade --cask --greedy

    echo "[upenv] Cleaning-up homebrew..."
    ${brew} cleanup
}

function update_conda {
    local mamba=$HOME/mamba/bin/mamba
    local nvim_env=$HOME/.dotfiles/config/nvim/neovim.yml

    echo "[upenv] Updating base conda environment..."
    ${mamba} --no-banner update -n base --all --yes

    echo "[upenv] Re-installing neovim conda environment..."
    ${mamba} env remove -n neovim --yes
    ${mamba} env create -f ${nvim_env}
    echo "[upenv] Installing neovim node package..."
    ${mamba} --no-banner run -n neovim --no-capture-output --live-stream npm install -g neovim
    echo "[upenv] Installing neovim ruby gem..."
    local prefix=$(${mamba} --no-banner run -n neovim --no-capture-output printenv CONDA_PREFIX)
    ${mamba} --no-banner run -n neovim --no-capture-output --live-stream gem install --bindir ${prefix}/bin neovim

    echo "[upenv] Re-installing further conda environments..."
    for k in $HOME/.dotfiles/envs/*.yml; do
        local bname=$(basename $k .yml)
        ${mamba} env remove -n ${bname}
        ${mamba} env create -n ${bname} -f ${k}
    done

    echo "[upenv] Cleaning-up conda installation..."
    ${mamba} clean --all --yes
}

function update_neovim {
    local nvim=$HOMEBREW_PREFIX/bin/nvim

    echo "[upenv] Updating nvim plugin manager..."
    ${nvim} --headless -c "Lazy! sync" +qa

    echo "[upenv] Updating language parsing and highlight..."
    ${nvim} --headless -c 'MasonUpdate' +qa
    ${nvim} --headless -c 'TSUpdateSync' +qa

}

function upenv {
    update_homebrew
    update_conda
    update_neovim
    echo "[upenv] Updating oh-my-zsh..."
    omz update
}
