if ! command -v starship &> /dev/null; then
    echo "[anjos-starship] \`starship\` not installed - not setting it up"
else
    eval "$(starship init zsh)"
fi
