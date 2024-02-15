# Integration with Kitty
if [[ -n "${KITTY_INSTALLATION_DIR}" ]]; then
    #echo "Enabling Kitty integration..."
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# Aliases specifically for Kitty
if [[ "$TERM" == "xterm-kitty" ]]; then
    function svim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=window --location=before
    }
    function xvim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=os-window
    }
    alias gvim=xvim
fi
