# Integrates direnv
if ! command -v direnv &> /dev/null
then
    echo "direnv not installed - disabling zsh extensions"
else
    eval "$(direnv hook zsh)"
fi
