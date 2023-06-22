source ${0:A:h}/starship.zsh
source ${0:A:h}/fzf.zsh
source ${0:A:h}/aliases.zsh
source ${0:A:h}/homebrew.zsh
source ${0:A:h}/mamba.zsh
source ${0:A:h}/neovim.zsh
source ${0:A:h}/terminal-setup.zsh
source ${0:A:h}/idiap.zsh
source ${0:A:h}/defaults.zsh
source ${0:A:h}/direnv.zsh

# Updates all installed software
function upsw {
    anjos-homebrew-update
    anjos-mamba-update
    anjos-neovim-update

    echo -e "\n[anjos-omz] Updating oh-my-zsh..."
    omz update
}
