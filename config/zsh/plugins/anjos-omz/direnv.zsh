if ! command -v direnv &> /dev/null
then
    echo "[anjos-direnv] \`direnv\` not installed - disabling zsh extensions"
else
    eval "$(direnv hook zsh)"
fi
