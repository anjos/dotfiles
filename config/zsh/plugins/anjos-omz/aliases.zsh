# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias h='history'

if type "vivid" > /dev/null; then
  export LS_COLORS=$(vivid generate solarized-dark)
fi
if type "lsd" > /dev/null; then
  alias ls='lsd --hyperlink=auto'
elif type "exa" > /dev/null; then
  alias ls='exa --git --classify --header --sort=modified'
fi
alias ll='ls --long'
alias la='ls --all'
alias lla='ll --all'
alias lt='ls --tree'

alias rm='rm -vi'
if type "grm" > /dev/null; then
  alias rm='grm -vi'
fi

alias cp='cp -vi'
if type "gcp" > /dev/null; then
  alias cp='gcp -vi'
fi

alias mv='mv -vi'
if type "gmv" > /dev/null; then
  alias mv='gmv -vi'
fi

if type "gchmod" > /dev/null; then
  alias chmod='gchmod -c'
  alias chown='gchown -c'
  alias chgrp='gchgrp -c'
fi

alias grep='grep --color'

if type "nvim" > /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi

if type "bat" > /dev/null; then
  alias cat='bat --style=plain'
fi

alias t='tmux -u'
alias tl='t ls'
alias tn='t new-session -A -s'
alias tc='t capture-pane -pt'

alias pipdev='pip install --no-build-isolation --no-dependencies --editable'
