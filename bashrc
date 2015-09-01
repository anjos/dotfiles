#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue  3 Sep 16:48:07 2013 CEST

# Initialization for **interactive** shells

# MacPorts installer addition: adding an appropriate PATH variable
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Completion
[ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion

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

if [ -d $HOME/work/npm/bin ]; then
  export PATH=$HOME/work/npm/bin:$PATH;
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
alias vi='mvim'
alias gvim='mvim'
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
eval `gdircolors --sh ~/.dircolors`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=10000;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

# A function to send commands to a remotely opened MacVim terminal
function tvim () {
  local started=`mvim --serverlist | wc -l`
  if (( ${started} > 0 )); then
    mvim --remote-tab $*
  else
    mvim $*
  fi
  return $?
}

# Removes duplicates from PATH
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# Sets up the core dump limits
ulimit -c unlimited;
