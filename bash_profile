# Initialization file for bash

# Completion
[ "$PS1" ] && [ -f /etc/bash_completion ] && source /etc/bash_completion

# So we know when we are root 
pr='>>';
col=lightblue;
if [ $UID = 0 ]; then
  pr='##';
  col=lightblue;
fi

if [ -e ~/.bash_colors.sh ]; then
	source ~/.bash_colors.sh;
	PS1=`colourise $col "["`"\h-\$(date +%k:%M)"`colourise $col "]"`" \W "`colourise $col "$pr"`" ";
else
	PS1="[\h-\$(date +%k:%M)] \W $pr "
fi

if [ -d ~/bin ]; then
  export PATH=$PATH:~/bin;
fi

#standard stuff
alias 'h=history'
alias 'm=less'
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

#ssh'ing aliases
alias adois='ssh andreanjos@pacer.dreamhost.com'
alias pacer='ssh andre@pacer.dreamhost.com'
alias casa='ssh andre@adois.dyndns.org'
alias lx='ssh lxplus.cern.ch'
pcuwtr() { ssh pcuwtr$1.cern.ch; }
pcatr() { ssh pcatr$1.cern.ch; }
pcatb() { ssh pcatb$1.cern.ch; }

export EDITOR=vim;
export VISUAL=vim;
export PAGER=less;

# Get of with CTRL-D
set +o ignoreeof

# Directory colorisation
eval `dircolors --sh ~/.dircolors`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=10000;

# Sets up the core dump limits
ulimit -c unlimited;

# This is for python initialization
export PYTHONSTARTUP=~/.python_profile.py

