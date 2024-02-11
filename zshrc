# Initialization for **interactive** shells

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

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
plugins+=(history-substring-search)
plugins+=(anjos-omz)
plugins+=(direnv)
plugins+=(conda-zsh-completion)
plugins+=(gitfast)
plugins+=(python)
plugins+=(themes)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(brew)
plugins+=(fd)
plugins+=(fzf)
plugins+=(docker)
plugins+=(docker-compose)

source $ZSH/oh-my-zsh.sh
