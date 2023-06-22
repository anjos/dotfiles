# Functions to update my neovim setup

# The nvim binary should be accessible
if ! command -v nvim &> /dev/null; then
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
