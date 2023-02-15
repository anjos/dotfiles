eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
direnv exec . nvim "$@"
