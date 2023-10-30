# Functions to update my neovim setup

# On linux, we may have installed the binary on our own bin directory
if [ -x "${HOME}/bin/nvim" ]; then
    export PATH="${HOME}/bin:${PATH}"
elif ! command -v nvim &> /dev/null; then
    # The nvim binary should be accessible
    echo "nvim not installed - not setting up special functions"
    return
fi

function anjos-neovim-update {
    echo "[anjos-neovim] Updating nvim plugin manager..."
    nvim --headless -c "Lazy! sync" +qa

    echo "[anjos-neovim] Updating language parsing and highlight..."
    nvim --headless -c 'MasonUpdate' +qa
    nvim --headless -c 'TSUpdateSync' +qa
}
