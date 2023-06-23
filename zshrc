# Initialization for **interactive** shells

# Default path setup.  Updates values at /etc/paths and /etc/manpaths
eval `/usr/libexec/path_helper`

# Path to your oh-my-zsh installation.
export ZSH="/Users/andre/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${HOME}/.dotfiles/config/zsh"

# Add wisely, as too many plugins slow down shell startup.
plugins=()
plugins+=(anjos-omz)
plugins+=(conda-zsh-completion)
plugins+=(gitfast)
plugins+=(python)
plugins+=(themes)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(history-substring-search)
plugins+=(brew)
plugins+=(fd)
plugins+=(fzf)

source $ZSH/oh-my-zsh.sh

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Removes duplicates from PATH and MANPATH
export PATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH)
export MANPATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$MANPATH)
