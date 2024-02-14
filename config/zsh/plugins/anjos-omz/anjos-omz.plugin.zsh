_ANJOS_BASEDIR=${0:A:h}

# Loads all sources
function anjos-reload {

    local modules=()
    modules+=(first)  # should be sourced first, always
    modules+=(homebrew)
    modules+=(duti)
    modules+=(macos-sdk)
    modules+=(mamba)
    modules+=(starship)
    modules+=(fzf)
    modules+=(neovim)
    modules+=(kitty)
    modules+=(idiap)  # depends on mamba setup!
    modules+=(defaults)
    modules+=(aliases)
    modules+=(last)  # should be sourced by last, always

    # We now source sub-plugins one by one, in this order:
    # 1. If the file ${module}.${hostname}.zsh exists, it is sourced.
    # 2. Else, if the file ${module}.${os}.zsh exits, it is sourced and
    #    processing for that module stops
    # 3. Finally, if the file ${module}.zsh exists, then it is sourced and processing
    #    for that module stops
    # If none of the variants exists, then the module is ignored
    os=$(uname | tr '[:upper:]' '[:lower:]')
    hostname=$(hostname -f)

    echo "[anjos-omz] Configuring shell for \`${os}\` at \`${hostname}\`"

    for module in "${modules[@]}"; do
        if [ -r "${_ANJOS_BASEDIR}/${module}.${hostname}.zsh" ]; then
            source "${_ANJOS_BASEDIR}/${module}.${hostname}.zsh"
        elif [ -r "${_ANJOS_BASEDIR}/${module}.${os}.zsh" ]; then
            source "${_ANJOS_BASEDIR}/${module}.${os}.zsh"
        elif [ -r "${_ANJOS_BASEDIR}/${module}.zsh" ]; then
            source "${_ANJOS_BASEDIR}/${module}.zsh"
        fi
    done

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
