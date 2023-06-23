# Functions to bootstrap and update mamba-forge/conda-forge environments

_ANJOS_MAMBA_PREFIX="${HOME}/mamba"
_ANJOS_MACOS_SDK="/opt/MacOSX11.0.sdk"  # required on macbooks with Apple silicon

# Installs macOS development kit required for conda builds
function anjos-macos-sdk-init {
    local sdk_ext=".tar.xz"
    local sdk_base=$(basename ${_ANJOS_MACOS_SDK})
    local sdk_dest=$(dirname ${_ANJOS_MACOS_SDK})
    echo "[anjos-mamba] Installing \`${sdk_base}\` at \`${sdk_dest}\` (requires sudo)..."
    curl -L -O "https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/${sdk_base}${sdk_ext}"
    sudo tar xf ${sdk_base}${sdk_ext} -C ${sdk_dest}
    rm -f ${sdk_base}${sdk_ext}
    sudo chown -R ${USER}:admin ${_ANJOS_MACOS_SDK}
}

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
  - https://www.idiap.ch/software/bob/conda/label/beta
  - https://www.idiap.ch/software/bob/conda
  - conda-forge
EOL

    echo "[anjos-mamba] Updating mamba base environment..."
    ${_ANJOS_MAMBA_PREFIX}/bin/mamba update -n base --all

    anjos-macos-sdk-init

    echo "[anjos-mamba] Installing development tools on base environment..."
    ${_ANJOS_MAMBA_PREFIX}/bin/mamba install -n base idiap-devtools

    echo "[anjos-mamba] Restart your shell so the command \`mamba\` can be accessed"
    echo "[anjos-mamba] Then, run \`anjos-mamba-update\` to install all packages"
    echo "[anjos-mamba] Also use \`anjos-mamba-update\` to keep the install up to date"
}

function anjos-mamba-deinit {
    echo "[anjos-mamba] Completely erasing mamba installation. Hold your horses..."
    rm -rf $(dirname $(dirname ${CONDA_EXE}))
    echo "[anjos-mamba] You may also want to erase macOS SDKs you have installed on \`/opt\`"
    echo "[anjos-mamba] E.g.: \`sudo rm -rf /opt/MacOSX*\`"
    echo "[anjos-mamba] Remember to unset any eventual zshrc initialisations you put in place."
}

# Setup conda, if possible, otherwise complain and exit
if [ -f ${_ANJOS_MAMBA_PREFIX}/etc/profile.d/conda.sh ]; then
   source ${HOME}/mamba/etc/profile.d/conda.sh

   if [ -r ${_ANJOS_MACOS_SDK} ]; then
       export OSX_SDK_DIR="$(dirname ${_ANJOS_MACOS_SDK})"
       export CONDA_BUILD_SYSROOT="${_ANJOS_MACOS_SDK}"
   else
       echo "[anjos-mamba] Cannot find \`${_ANJOS_MACOS_SDK}\`, not setting up build variables..."
       echo "[anjos-mamba] Run \`anjos-macos-sdk-init\` to install it"
   fi

else
    echo "[anjos-mamba] Cannot find \`${_ANJOS_MAMBA_PREFIX}\`, not setting up conda paths..."
    echo "[anjos-mamba] Run \`anjos-mamba-init\` to install it"
    return
fi

function _anjos-mamba-update-base {
    echo "[anjos-mamba] Updating base conda environment..."
    mamba --no-banner update -n base --all --yes
}

function _anjos-mamba-overwrite-environment {
    echo "[anjos-mamba] Deleting and re-creating environment ${1} (from ${2})..."
    mamba env create --force -n ${1} -f ${2}
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
    mamba clean --all --yes
}

function _anjos-mamba-run-on {
    mamba --no-banner run -n ${1} --no-capture-output --live-stream "${@:2}"
}

function _anjos-mamba-reinstall-neovim-environment {
    echo "[anjos-mamba] Re-installing neovim conda environment..."
    _anjos-mamba-overwrite-environment neovim ${_ANJOS_BASEDIR}/../../../nvim/neovim.yml

    echo "[anjos-mamba] Installing neovim node package..."
    _anjos-mamba-run-on neovim npm install -g neovim

    echo "[anjos-mamba] Installing neovim ruby gem..."
    local prefix=$(mamba --no-banner run -n neovim --no-capture-output printenv CONDA_PREFIX)
    _anjos-mamba-run-on neovim gem install --bindir ${prefix}/bin neovim

    echo "[anjos-mamba] Installing luarocks package manager..."
    local rocks_version="3.9.2"
    _anjos-mamba-run-on neovim curl --location -o luarocks-${rocks_version}.tar.gz https://luarocks.org/releases/luarocks-${rocks_version}.tar.gz
    tar xf luarocks-${rocks_version}.tar.gz
    cd luarocks-${rocks_version}
    _anjos-mamba-run-on neovim ./configure --prefix=${prefix} --with-lua=${prefix} --sysconfdir=${prefix}/share/lua/ --rocks-tree=${prefix}
    _anjos-mamba-run-on neovim make bootstrap
    cd ..
    rm -rf luarocks-${rocks_version}{,.tar.gz}
}

function anjos-mamba-update {
    _anjos-mamba-update-base
    _anjos-mamba-reinstall-neovim-environment
    _anjos-mamba-reinstall-environments
    _anjos-mamba-cleanup
}
