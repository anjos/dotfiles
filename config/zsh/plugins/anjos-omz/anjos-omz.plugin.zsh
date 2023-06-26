_ANJOS_BASEDIR=${0:A:h}

# Loads all sources
function anjos-reload {
    source ${_ANJOS_BASEDIR}/first.zsh  # should be sourced first, always
    source ${_ANJOS_BASEDIR}/homebrew.zsh
    source ${_ANJOS_BASEDIR}/macos-sdk.zsh
    source ${_ANJOS_BASEDIR}/mamba.zsh
    source ${_ANJOS_BASEDIR}/starship.zsh
    source ${_ANJOS_BASEDIR}/fzf.zsh
    source ${_ANJOS_BASEDIR}/aliases.zsh
    source ${_ANJOS_BASEDIR}/neovim.zsh
    source ${_ANJOS_BASEDIR}/terminal-setup.zsh
    source ${_ANJOS_BASEDIR}/idiap.zsh  # depends on mamba setup!
    source ${_ANJOS_BASEDIR}/defaults.zsh
    source ${_ANJOS_BASEDIR}/direnv.zsh
    source ${_ANJOS_BASEDIR}/orquidea.zsh
    source ${_ANJOS_BASEDIR}/last.zsh  # should be sourced by last, always
}

# Updates all installed software
function anjos-update {
    anjos-homebrew-update
    anjos-mamba-update
    anjos-neovim-update

    echo -e "\n[anjos-omz] Updating oh-my-zsh..."
    omz update
}

anjos-reload
