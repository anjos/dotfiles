_ANJOS_BASEDIR=${0:A:h}

# auto-completion startup
autoload -U compinit && compinit

# Loads all sources
function anjos-reload {

    local units=()
    units+=(first)  # should be sourced first, always
    units+=(homebrew)
    units+=(duti)
    units+=(macos-sdk)
    units+=(pixi)
    units+=(starship)
    units+=(fzf)
    units+=(neovim)
    units+=(kitty)
    units+=(idiap)
    units+=(defaults)
    units+=(aliases)
    units+=(last)  # should be sourced by last, always

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

    for module in "${units[@]}"; do
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
    _run-if-exists anjos-pixi-update
    _run-if-exists anjos-neovim-update
    _run-if-exists anjos-duti-setup
    _run-if-exists omz update
}

anjos-reload
