# START bash completion -- do not remove this line
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ] \
   && [ -f /etc/bash_completion ]; then # interactive shell
        # Source completion code
        . /etc/bash_completion
fi
unset bash bmajor bminor
# END bash completion -- do not remove this line

if [ -e ~/script/ansi.sh ]; then
	source ~/script/ansi.sh;
	PS1=`colourise lightblue "["`"\h-\$(date +%k:%M)"`colourise lightblue "]"`" \W "`colourise lightblue ">>"`" ";
else
	PS1="[\h-\$(date +%k:%M)] \W >> "
fi

if [ -d ~/bin ]; then
  export PATH=$PATH:~/bin;
fi

alias 'h=history'		  # just type h for the history
alias 'm=less'                	  # just type m not more
alias ls='ls --color=auto -F -t'
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
alias edit='gnuclient -q -h pcatd37 -display ":0.0"'
alias more='less'
alias vim='vim -c "set background=dark"'

if [ -x /usr/bin/vim ]; then
	export EDITOR=vim;
  alias vi='vim'
else
	export EDITOR=vi;
fi

export PAGER=less;

# Get of with CTRL-D
set +o ignoreeof

# Directory colorisation
eval `dircolors --sh ~/.DIR_COLORS`;

# Sets up the history
export HISTFILE=${HOME}/.bash_history;
export HISTSIZE=10000;

# Sets up the core dump limits
#ulimit -c unlimited;

