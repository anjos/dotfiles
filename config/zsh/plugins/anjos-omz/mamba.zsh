# Functions to bootstrap and update mamba-forge/conda-forge environments

_ANJOS_MAMBA_PREFIX="${HOME}/mamba"

# Setup conda, if possible, otherwise complain and exit
if [ -f ${_ANJOS_MAMBA_PREFIX}/etc/profile.d/conda.sh ]; then
    source ${_ANJOS_MAMBA_PREFIX}/etc/profile.d/conda.sh

    if [ -d ${_ANJOS_MACOS_SDK} ]; then
        export CONDA_BUILD_SYSROOT="${_ANJOS_MACOS_SDK}"
    fi

    _ANJOS_MAMBA_BIN="${_ANJOS_MAMBA_PREFIX}/bin/mamba"

    function anjos-mamba-deinit {
        echo "[anjos-mamba] Completely erasing mamba installation. Hold your horses..."
        rm -rf $(dirname $(dirname ${CONDA_EXE}))
        echo "[anjos-mamba] You may also want to erase macOS SDKs you have installed on \`/opt\`"
        echo "[anjos-mamba] E.g.: \`sudo rm -rf /opt/MacOSX*\`"
        echo "[anjos-mamba] Remember to unset any eventual zshrc initialisations you put in place."
    }

else
    echo "[anjos-mamba] Cannot find \`${_ANJOS_MAMBA_PREFIX}\`, not setting up conda paths..."
    echo "[anjos-mamba] Run \`anjos-mamba-init\` to install it"

    # Installs mambaforge for the first time
    function anjos-mamba-init {
        echo "[anjos-mamba] Installing mambaforge from official web sources to \`${prefix}\`..."
        curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
        # options are:
        # -b           run install in batch mode (without manual intervention),
        #              it is expected the license terms (if any) are agreed upon
        # -f           no error if install prefix already exists
        # -h           print this help message and exit
        # -p PREFIX    install prefix, defaults to /Users/andre/mambaforge, must not contain spaces.
        # -s           skip running pre/post-link/install scripts
        # -u           update an existing installation
        # -t           run package tests after installation (may install conda-build)
        /bin/bash Mambaforge-$(uname)-$(uname -m).sh -b -f -u -p ${_ANJOS_MAMBA_PREFIX}

        echo "[anjos-mamba] Configuring mamba..."
        cat >${_ANJOS_MAMBA_PREFIX}/condarc <<EOL
changeps1: false
show_channel_urls: true
channel_priority: strict
channels:
  - conda-forge
EOL

        echo "[anjos-mamba] Updating mamba base environment..."
        ${_ANJOS_MAMBA_PREFIX}/bin/mamba update -n base --all

        echo "[anjos-mamba] Restart your shell so the command \`mamba\` can be accessed"
        echo "[anjos-mamba] Then, run \`anjos-mamba-update\` to install all packages"
        echo "[anjos-mamba] Also use \`anjos-mamba-update\` to keep the install up to date"
    }

    return
fi

function _anjos-mamba-update-base {
    echo "[anjos-mamba] Updating base conda environment..."
    ${_ANJOS_MAMBA_BIN} --no-banner update -n base --all --yes
}

function _anjos-mamba-overwrite-environment {
    echo "[anjos-mamba] Deleting and re-creating environment ${1} (from ${2})..."
    ${_ANJOS_MAMBA_BIN} env create --force -n ${1} -f ${2}
}

function _anjos-mamba-reinstall-environments {
    echo "[anjos-mamba] Re-installing conda environments..."

    local environments=(${_ANJOS_BASEDIR}/mamba-environments/*.yml)

    for k in "${environments[@]}"; do
        _anjos-mamba-overwrite-environment $(basename $k .yml) ${k}
    done
}

function _anjos-mamba-cleanup {
    echo "[anjos-mamba] Cleaning-up conda installation..."
    ${_ANJOS_MAMBA_BIN} clean --all --yes
}

# Runs an executable (not function or alias) from an environment.  If the
# environment is set, then call the command from the environment.  Else, wrap
# the execuable on a `mamba run` statement
function anjos-mamba-run-on {
    # if the environment is set, then just run the command
    if [[ "${CONDA_DEFAULT_ENV}" == "${1}" ]]; then
        print -P "%F{green}[mamba] calling \"${2}\" from the currently active enviroment...%f"
        "${@:2}"
    else
        print -P "%F{yellow}[mamba] calling \"${2}\" from inactive enviroment \"${1}\"...%f"
        ${_ANJOS_MAMBA_BIN} --no-banner run -n ${1} --live-stream "${@:2}"
    fi
}

function _anjos-mamba-reinstall-shell-environment {
    echo "[anjos-mamba] Re-installing (special) shell conda environment..."
    _anjos-mamba-overwrite-environment shell ${_ANJOS_BASEDIR}/mamba-environments/special/shell.yml

    local utils=()  # commented out utilities are installed via mamba!
    # utils+=('bat')   # alternative to cat
    # utils+=('fd-find')  # find replacement
    # utils+=('git-delta')  # for nice git diffs
    # utils+=('lsd')  # ls replacement (not compiling on mamba currently)
    # utils+=('ripgrep')  # grep replacement
    # utils+=('starship')  # multi-shell prompt
    utils+=('vivid')  # color theme generator for shell
    echo "[anjos-mamba] Installing rust shell utilities via cargo..."
    anjos-mamba-run-on shell cargo install --root ${_ANJOS_MAMBA_PREFIX}/envs/shell "${utils[@]}"
}

function _anjos-mamba-reinstall-neovim-environment {
    echo "[anjos-mamba] Re-installing (special) neovim conda environment..."
    _anjos-mamba-overwrite-environment neovim ${_ANJOS_BASEDIR}/mamba-environments/special/neovim.yml

    echo "[anjos-mamba] Installing neovim node package..."
    anjos-mamba-run-on neovim npm install -g neovim

    echo "[anjos-mamba] Installing neovim ruby gem..."
    local prefix=$(mamba --no-banner run -n neovim --no-capture-output printenv CONDA_PREFIX)
    anjos-mamba-run-on neovim gem install --bindir ${prefix}/bin neovim

    echo "[anjos-mamba] Installing luarocks package manager..."
    local rocks_version="3.9.2"
    anjos-mamba-run-on neovim curl --location -o luarocks-${rocks_version}.tar.gz https://luarocks.org/releases/luarocks-${rocks_version}.tar.gz
    tar xf luarocks-${rocks_version}.tar.gz
    cd luarocks-${rocks_version}
    anjos-mamba-run-on neovim ./configure --prefix=${prefix} --with-lua=${prefix} --sysconfdir=${prefix}/share/lua/ --rocks-tree=${prefix}
    anjos-mamba-run-on neovim make bootstrap
    cd ..
    rm -rf luarocks-${rocks_version}{,.tar.gz}
}

function anjos-mamba-update {
    #_anjos-mamba-update-base
    _anjos-mamba-reinstall-shell-environment
    _anjos-mamba-reinstall-neovim-environment
    _anjos-mamba-reinstall-environments
    _anjos-mamba-cleanup
}

# looks-up addresses and phone numbers on Idiap's LDAP server
function anjos-mamba-ldap-tel {
    anjos-mamba-run-on ldap ldap-idiap.py "$@"
}
alias tel=anjos-mamba-ldap-tel

# we always have this one ready for shell interaction
if [ -d "${_ANJOS_MAMBA_PREFIX}/envs/shell" ]; then
  export PATH="${_ANJOS_MAMBA_PREFIX}/envs/shell/bin:${PATH}"
fi
