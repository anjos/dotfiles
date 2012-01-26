# Initialization file for bash

# Idiap environment (do NOT erase)
[ -f /idiap/resource/software/initfiles/shrc ] && source /idiap/resource/software/initfiles/shrc;

# Completion
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

if [ -d ~/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

function tvim () {
  local started=`gvim --serverlist | wc -l`
  if (( ${started} > 0 )); then
    gvim --remote-tab $*
  else
    gvim $*
  fi
}

#standard stuff
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

#idiap
alias qsub='grid qsub'
alias qstat='grid qstat'
alias qdel='grid qdel'
alias qman='grid man'
alias matlab='setshell.py matlab matlab'

#ssh'ing aliases
alias adois='ssh andreanjos@pacer.dreamhost.com'
alias pacer='ssh andre@pacer.dreamhost.com'
alias casa='ssh andre@orquidea.andreanjos.org'
alias lx='ssh rabello@lxplus.cern.ch'

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

# Sets up the core dump limits
ulimit -c unlimited;
