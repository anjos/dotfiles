# Functions to bootstrap and maintain pixi environments

# Setup pixi, if possible, otherwise complain and exit

export PIXI_HOME="${HOME}/.config/pixi"

if [ -x "${PIXI_HOME}/bin/pixi" ]; then
    export PATH="${PIXI_HOME}/bin:${PATH}"
    eval "$(pixi completion --shell zsh)"
else
    echo "[anjos-pixi] Cannot find \`${PIXI_HOME}/bin/pixi\` executable, not setting up..."
    echo "[anjos-pixi] Run \`anjos-pixi-init\` to install it"

    # Installs pixi for the first time
    function anjos-pixi-init {
        echo "[anjos-pixi] Installing pixi from official web sources..."
        export PIXI_NO_PATH_UPDATE=1
        curl -fsSL https://pixi.sh/install.sh | bash
        unset PIXI_NO_PATH_UPDATE
        echo "[anjos-pixi] Restart your shell so the command \`pixi\` can be accessed"
    }

    return
fi

function anjos-pixi-deinit {
    echo "[anjos-pixi] Completely erasing pixi installation. Hold your horses..."
    rm -rf ${PIXI_HOME}
    echo "[anjos-pixi] You may also want to erase macOS SDKs you have installed on \`/opt\`"
    echo "[anjos-pixi] E.g.: \`sudo rm -rf /opt/MacOSX*\`"
    echo "[anjos-pixi] Remember to unset any eventual zshrc initialisations you put in place."
}

function anjos-pixi-global-update {
    echo "[anjos-pixi] Self-updating ..."
    pixi self-update --force
    pixi global upgrade-all
}

function anjos-pixi-global-install {
    echo "[anjos-pixi] Installing all global packages ..."

    local pkgs=()
    pkgs+=('bat')
    pkgs+=('coreutils')
    pkgs+=('curl')
    pkgs+=('exa')
    pkgs+=('fd-find')
    pkgs+=('findutils')
    pkgs+=('fzf')
    pkgs+=('git')
    pkgs+=('git-delta')
    pkgs+=('git-filter-repo')
    pkgs+=('git-lfs')
    pkgs+=('graphviz')
    pkgs+=('grep')
    pkgs+=('htop')
    pkgs+=('imagemagick')
    pkgs+=('latexindent.pl')
    pkgs+=('latexdiff')
    pkgs+=('lsdeluxe')
    pkgs+=('pip')
    pkgs+=('python=3')
    pkgs+=('ripgrep')
    pkgs+=('rust')
    pkgs+=('starship')
    pkgs+=('tar')
    pkgs+=('texlab')
    pkgs+=('tmux')
    pkgs+=('tree')
    pkgs+=('vivid')
    pkgs+=('xz')
    pkgs+=('wget')
    pkgs+=('zoxide')

    pixi global install "${pkgs[@]}"
}


# Runs an executable (not function or alias) from an environment.  If the
# environment is set, then call the command from the environment.  Else, wrap
# the execuable on a `pixi run` statement
function anjos-pixi-run-on {
    local _basedir=$(dirname "${1}")
    if [ -d "${_basedir}/.pixi/envs/default" ]; then
        pixi run --manifest-path "${1}" "${2}"
    fi
}

function anjos-pixi-reinstall-environments {
    echo "[anjos-pixi] Re-installing pixi environments..."

    local environments=(${_ANJOS_BASEDIR}/pixies/*/pixi.toml)

    for k in "${environments[@]}"; do
        echo "[anjos-pixi] Removing environment at ${k}..."
        \rm -rf $(dirname ${k})/.pixi
        echo "[anjos-pixi] Installing environment ${k}..."
        pixi run --manifest-path ${k} build
    done
}

function anjos-pixi-update {
    anjos-pixi-global-update
    anjos-pixi-reinstall-environments
}

if [ -d $HOME/work/software/idiap-devtools/.pixi/envs/default ]; then
    alias devtool="anjos-pixi-run-on $HOME/work/software/idiap-devtools/pixi.toml devtool"
fi

if [ -d "${_ANJOS_BASEDIR}/pixies/ldap/.pixi/envs/default" ]; then
    alias tel="anjos-pixi-run-on ${_ANJOS_BASEDIR}/pixies/ldap/pixi.toml ${_ANJOS_BASEDIR}/pixies/ldap/idiap.py devtool"
fi
