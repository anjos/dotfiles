#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Fri  2 Mar 14:07:57 2018 CET

# Initialization for **interactive** shells

export PATH=/usr/local/bin:/usr/local/sbin:/Library/TeX/texbin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# bash-completion from homebrew
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# So we know when we are root
pr='>>';
col=lightblue;
if [ $UID = 0 ]; then
  pr='##';
  col=lightred;
fi

if [ -e ~/.bash_colors.sh ]; then
	. ~/.bash_colors.sh;
	PS1=`colourise $col "["`"\$(date +%k:%M)"`colourise $col "]"`" \W "`colourise $col "$pr"`" ";
else
	PS1="[\$(date +%k:%M)] \W $pr "
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Standard aliases
alias 'h=history'
alias 'm=less -R'
alias ls='gls --color=auto -F -t -r -t'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias rm='grm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias tm='tail -f /var/log/messages'
alias dire='ls -alt'
alias t='less'
alias tn='less -N'
alias more='less'
alias chmod='gchmod -c'
alias chown='gchown -c'
alias chgrp='gchgrp -c'
alias grep='grep --color'
alias vi='nvim'
alias vim='nvim'
alias ipy='ipython --no-banner'
alias ccat='highlight -O ansi'
alias sb='sphinx-build'

# Programs controlled by environment variables
export EDITOR=nvim;
export VISUAL=nvim;
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";

# Get of with CTRL-D
set +o ignoreeof

# Directory colorisation
eval `gdircolors --sh ~/.dircolors`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=10000;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# A function to start a new iTerm window with the neovim profile
function xvim () {
  cmd="/usr/local/bin/nvim"
  for entry in "$@"; do cmd="${cmd} \\\"${entry}\\\""; done
  #echo "${cmd}"
  osascript &>/dev/null <<EOF
    tell application "iTerm2"
      create window with profile "Neovim" command "$cmd"
    end tell
EOF
}
alias gvim='xvim'

# A function to start a new tunnel to my machine at Idiap
function tunnel () {
  if [ $# == 0 ]; then
    echo "Creates a tunnel between local and remote ports on idiap"
    echo "tunnel <remote-port>  # binds remote port to same local port"
    echo "tunnel <local-port> <remote-port>  # binds local to remote port"
    return 1
  fi
  local local_port=$1
  if [ $# == 1 ]; then
    local remote_port=$1
  else
    local remote_port=$2
  fi
  ssh -N -L ${local_port}:italix22.idiap.ch:${remote_port} idiap
}

alias gvim='xvim'

# Removes duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# Sets up the core dump limits
ulimit -c 0;

# Conda setup
if [ -x ${HOME}/conda/bin/conda ]; then
  source ${HOME}/conda/etc/profile.d/conda.sh
  export CONDA_BUILD_SYSROOT="/opt/MacOSX10.9.sdk"
fi
