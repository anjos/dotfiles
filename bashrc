#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Fri  2 Mar 14:07:57 2018 CET

# Initialization for **interactive** shells

# MacPorts installer addition: adding an appropriate PATH variable
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH

# Completion for MacPorts
[ -f /opt/local/etc/profile.d/bash_completion.sh ] && source /opt/local/etc/profile.d/bash_completion.sh;

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
  cmd="/opt/local/bin/nvim"
  for entry in "$@"; do cmd="${cmd} \\\"${entry}\\\""; done
  #echo "${cmd}"
  osascript &>/dev/null <<EOF
    tell application "iTerm2"
      create window with profile "Neovim" command "$cmd"
    end tell
EOF
}
alias gvim='xvim'

# Removes duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# Sets up the core dump limits
ulimit -c unlimited;

# Conda setup
if [ -x ${HOME}/conda/bin/conda ]; then
  source ${HOME}/conda/etc/profile.d/conda.sh
fi
