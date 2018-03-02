#!/usr/bin/env sh
# Andre Anjos <andre.dos.anjos@gmail.com>
# Fri  2 Mar 14:07:57 2018 CET

# Understand how bashrc, bash_profile, profile and inputrc are used:
#
# 1. If you start bash from a graphical user interface, only bashrc will be
# sourced.
#
# 2. If you login using your computer login terminal (not the graphical login
# system) or through SSH, then only bash_profile will be executed. Normally, we
# setup bash_profile so that it executes the contents of profile and then
# bashrc, if the shell is supposed to be interactive.
#
# 3. The file inputrc is only read/executed by bash for interactive shells.

# Interactive initialization file for bash (very specific)

# Idiap environment
if [ -f /idiap/resource/software/initfiles/shrc ]; then
  source /idiap/resource/software/initfiles/shrc;
fi

# Conda environment
if [ -d /scratch/aanjos/conda ]; then
  export PATH=/scratch/aanjos/conda/bin:$PATH;
fi

# Adds my bin directory to the search list
if [ -d ~/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Bash completion
if [ -z "$BASH_COMPLETION" ]; then
  if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
  fi
fi

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
alias vi='nvim'
alias ipy='ipython --no-banner'
alias ccat='highlight -O ansi'

# Programs controlled by environment variables
export EDITOR=nvim;
export VISUAL=nvim;
export PAGER=less;
export LESS="-R";
export LESSOPEN="|${HOME}/.lesspygments.sh %s";
export GPGKEY="A2170D5D";

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

# Sets up the core dump limits - if I'm on my machine
conf_user=$USER;
if [ -x /usr/sbin/custom-conf-getuser ]; then
  conf_user=$(/usr/sbin/custom-conf-getuser);
fi

if [ "$conf_user" = "$USER" ]; then
  ulimit -c unlimited;
fi

# Powerline
POWERLINE_BASH=${HOME}/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh;
if [ -r "${POWERLINE_BASH}" ]; then
  ${HOME}/.local/bin/powerline-daemon -q;
  POWERLINE_CONFIG=${HOME}/.local/bin/powerline-config;
  POWERLINE_BASH_CONTINUATION=1;
  POWERLINE_BASH_SELECT=1;
  source "${POWERLINE_BASH}";
fi
