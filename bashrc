#!/usr/bin/env sh
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue 03 Sep 2013 15:55:27 CEST

# Interactive initialization file for bash (very specific)

# Bash completion
[ -n "$PS1" ] && [ -z "$BASH_COMPLETION" ] && [ -f /etc/bash_completion ] && source /etc/bash_completion;

# So we know when we are root
pr='>>';
col=lightblue;
if [ $UID = 0 ]; then
  pr='##';
  col=lightred;
fi

if [ -e ~/.bash_colors.sh ]; then
	source ~/.bash_colors.sh;
	PS1=`colourise $col "["`"\h-\$(date +%k:%M)"`colourise $col "]"`" \W "`colourise $col "$pr"`" ";
else
	PS1="[\h-\$(date +%k:%M)] \W $pr "
fi

# Adds a new tab to a graphical vim instance
function tvim () {
  local started=`gvim --serverlist | wc -l`
  if (( ${started} > 0 )); then
    gvim --remote-tab $*
  else
    gvim $*
  fi
}

# Aliases for interactive shells
alias 'h=history'
alias 'm=less -R'
alias ls='ls --color=auto -F -t -r -t'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias chmod='chmod -c'
alias chown='chown -c'
alias chgrp='chgrp -c'
alias cds='cd /etc/rc.d/init.d && ls'
alias tm='tail -f /var/log/messages'
alias dire='ls -alt'
alias t='less'
alias tn='less -N'
alias more='less'
alias grep='grep --color'
alias ipy='ipython'
alias xo='xdg-open'
alias qsub='grid qsub'
alias qstat='grid qstat'
alias qdel='grid qdel'
alias qman='grid man'
alias matlab='setshell.py matlab matlab'

# Useful environment variables for interactive shells
export EDITOR=vim;
export VISUAL=vim;
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";

# Get off with CTRL-D
set +o ignoreeof

# Directory colorisation
eval `dircolors --sh ~/.dircolors`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=100000;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# Removes duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# Removes '.' from PATH (Idiap default)
export PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/\./ {next} {print}' | sed 's/:*$//'`;
