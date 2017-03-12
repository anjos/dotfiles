#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue  3 Sep 16:48:07 2013 CEST

# Initialization for **interactive** shells

# QNAP installer addition: adding an appropriate PATH variable
export PATH=$HOME/conda/bin:/opt/bin:/opt/sbin:$PATH

# Completion for MacPorts
[ -f /opt/etc/profile.d/bash_completion.sh ] && source /opt/etc/profile.d/bash_completion.sh;

# So we know when we are root
pr='>>';
col=lightblue;
if [ $UID = 0 ]; then
  pr='##';
  col=lightred;
fi

if [ -e ~/.bash_colors.sh ]; then
	. ~/.bash_colors.sh;
	PS1=`colourise $col "["`"\h-\$(date +%k:%M)"`colourise $col "]"`" \W "`colourise $col "$pr"`" ";
else
	PS1="[\h-\$(date +%k:%M)] \W $pr "
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

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
alias tm='tail -f /var/log/messages'
alias dire='ls -alt'
alias t='less'
alias tn='less -N'
alias more='less'
alias chmod='chmod -c'
alias chown='chown -c'
alias chgrp='chgrp -c'
alias grep='grep --color'
alias vi='mvim'
alias gvim='vim'
alias ipy='ipython --no-banner'

# Programs controlled by environment variables
export EDITOR=vim;
export VISUAL=vim;
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";

# Get of with CTRL-D
set +o ignoreeof

# Directory colorisation
eval `dircolors --sh ~/.dircolors`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=10000;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# Removes duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# Sets up the core dump limits
ulimit -c unlimited;
