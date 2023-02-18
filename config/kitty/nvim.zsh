eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
exec direnv exec . nvim "$@"
