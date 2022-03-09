#!/usr/bin/env zsh
# Andre Anjos <andre.dos.anjos@gmail.com>
# 2022-03-02 15:38

# Initialization for **interactive** shells

# Default path setup
# Update values at /etc/paths and /etc/manpaths
eval `/usr/libexec/path_helper`

# Adds homebrewsetup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Conda setup
if [ -f ${HOME}/mamba/etc/profile.d/conda.sh ]; then
  source ${HOME}/mamba/etc/profile.d/conda.sh
  export CONDA_BUILD_SYSROOT="/opt/MacOSX11.0.sdk"
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
ZSH_THEME="mine"

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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()
plugins+=(conda-zsh-completion)
plugins+=(docker)
#plugins+=(git)
plugins+=(gitfast)
plugins+=(python)
plugins+=(themes)
plugins+=(z)
#plugins+=(autojump)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

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
if type "gls" > /dev/null; then
  alias ls='gls --color=auto -F -t -r -t'
fi
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
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
alias ccat='highlight -O ansi'
alias t='tmux'
alias tl='tmux ls'
alias tn='tmux new-session -A -s'
alias tc='tmux capture-pane -pt'
alias it='ssh -t idiap tmux'
alias itn='it new-session -A -s'
alias itc='it capture-pane -pt'
alias itl='it ls'

# A function to start a new iTerm window with the neovim profile
function xvim () {
  $HOME/.xvim.py "$@"
}
alias gvim='xvim'

# Programs controlled by environment variables
export EDITOR=nvim;
export VISUAL=nvim;
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";

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

# A function to update all installed pip packages
function pipupdate() {
  if [[ $# == 0 ]]; then
    echo "Updates a pip installation package set"
    echo "$ pipupdate \`which pip\`"
    return 1
  fi
  echo "Updating ${1} packages..."
  [ ! -x "${1}" ] && return
  ${1} list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 ${1} install -U;
}

# This function will list a password from keychain
function getpass() {
    security find-generic-password -w -a $LOGNAME -s "${1}"
}

# This starts a VPN tunnel to Idiap
function vpn() {
    sudo openfortivpn sslvpn.idiap.ch:443 --username=aanjos --trusted-cert 36e9b7ab8fac6699da2f617a58b4fb32e140a62352bcde30569d6a5ea09d0b4e --pppd-use-peerdns=1
}

# Sets up the core dump limits
ulimit -c 0;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# Integration with iTerm2
if [ -r "${ZSH_CUSTOM}/iterm2_shell_integration.zsh" ]; then
    source "${ZSH_CUSTOM}/iterm2_shell_integration.zsh"
fi
