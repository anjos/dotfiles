# Integration with iTerm2 and Kitty
if [[ -n "${ITERM_SESSION_ID}" && -r "${ZSH_CUSTOM}/iterm2_shell_integration.zsh" ]]; then
    #echo "Enabling iTerm2 integration..."
    source "${ZSH_CUSTOM}/iterm2_shell_integration.zsh"
elif [[ -n "${KITTY_INSTALLATION_DIR}" ]]; then
    #echo "Enabling Kitty integration..."
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# Aliases specifically for Kitty
if [[ "$TERM" == "xterm-kitty" ]]; then
    alias ssh="kitty +kitten ssh"
    function svim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=window --location=before
    }
    function xvim() {
        KITTY_CLONE_SOURCE_CODE="[[ $# == 0 ]] && exec nvim || exec nvim \"${@}\"" clone-in-kitty --type=os-window
    }
    alias gvim=xvim
fi
