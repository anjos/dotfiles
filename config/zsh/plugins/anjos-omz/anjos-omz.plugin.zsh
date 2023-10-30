_ANJOS_BASEDIR=${0:A:h}

# Loads all sources
function anjos-reload {
    source ${_ANJOS_BASEDIR}/first.zsh  # should be sourced first, always
    source ${_ANJOS_BASEDIR}/homebrew.zsh
    source ${_ANJOS_BASEDIR}/duti.zsh
    source ${_ANJOS_BASEDIR}/macos-sdk.zsh
    source ${_ANJOS_BASEDIR}/mamba.zsh
    source ${_ANJOS_BASEDIR}/starship.zsh
    source ${_ANJOS_BASEDIR}/fzf.zsh
    source ${_ANJOS_BASEDIR}/neovim.zsh
    source ${_ANJOS_BASEDIR}/kitty.zsh
    source ${_ANJOS_BASEDIR}/idiap.zsh  # depends on mamba setup!
    source ${_ANJOS_BASEDIR}/defaults.zsh
    source ${_ANJOS_BASEDIR}/orquidea.zsh
    source ${_ANJOS_BASEDIR}/aliases.zsh
    source ${_ANJOS_BASEDIR}/last.zsh  # should be sourced by last, always
}

function _run-if-exists {
    if typeset -f $1 > /dev/null; then
        echo "[anjos-omz] Running $@..."
        "$@";
    fi
}

# Updates all installed software
function anjos-update {
    _run-if-exists anjos-homebrew-update
    _run-if-exists anjos-mamba-update
    _run-if-exists anjos-neovim-update
    _run-if-exists anjos-duti-setup
    _run-if-exists omz update
}

anjos-reload
