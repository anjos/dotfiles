#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# 2019-11-20 17:03

# Initialization for **interactive** shells

# Idiap environment
if [ -r /idiap/resource/software/initfiles/shrc ]; then
    source /idiap/resource/software/initfiles/shrc
fi

# Conda setup
if [ -f /idiap/user/aanjos/mamba/etc/profile.d/conda.sh ]; then
  source /idiap/user/aanjos/mamba/etc/profile.d/conda.sh
fi

if [ -d ${HOME}/bin ]; then
  export PATH="${HOME}/bin:${PATH}"
fi

# Removes duplicates from PATH
export PATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH)

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

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
plugins+=(git)
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
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
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

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Standard aliases
alias 'h=history'
alias 'm=less -R'
alias ls='ls --color=auto -F -t -r -t'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias grep='grep --color'
if type "nvim" > /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
elif type "vim" > /dev/null; then
  alias vi='vim'
fi
alias ccat='highlight -O ansi'
alias t='tmux'
alias tl='tmux ls'
alias tn='tmux new-session -A -s'
alias tc='tmux capture-pane -pt'
alias qprojects='qconf -sprjl'
alias qi="qrsh  -l 'pytorch,sgpu' -l 'hostname=vgn*' -now no -P masterai -l gpumem=24G"

# Programs controlled by environment variables
if type "nvim" > /dev/null; then
  export EDITOR=nvim;
  export VISUAL=nvim;
elif type "vim" > /dev/null; then
  export EDITOR=vim;
  export VISUAL=vim;
else
  export EDITOR=vi;
  export VISUAL=vi;
fi
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";

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

# Sets up the core dump limits
ulimit -c 0;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py
