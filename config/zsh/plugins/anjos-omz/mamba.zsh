# Functions to bootstrap and update mamba-forge/conda-forge environments

# The brew binary should be accessible
if ! command -v mamba &> /dev/null; then
    echo "mamba not installed - not setting up special functions"
    return
fi

function _anjos-mamba-update-base {
    echo "[anjos-mamba] Updating base conda environment..."
    mamba --no-banner update -n base --all --yes
}

_ANJOS_MAMBA_ENVIRONMENTS=(${0:A:h}/mamba-environments/*.yml)

function _anjos-mamba-reinstall-environments {
    echo "[anjos-mamba] Re-installing conda environments..."
    for k in "${_ANJOS_MAMBA_ENVIRONMENTS[@]}"; do
        local bname=$(basename $k .yml)
        mamba env remove -n ${bname}
        mamba env create -n ${bname} -f ${k}
    done
}

function _anjos-mamba-cleanup {
    echo "[anjos-mamba] Cleaning-up conda installation..."
    mamba clean --all --yes
}

_ANJOS_MAMBA_NEOVIM_ENVIRONMENT=(${0:A:h}/../../../nvim/neovim.yml)

function _anjos-mamba-reinstall-neovim-environment {
    echo "[anjos-mamba] Re-installing neovim conda environment..."
    mamba env remove -n neovim --yes
    mamba env create -f ${_ANJOS_MAMBA_NEOVIM_ENVIRONMENT}

    echo "[anjos-mamba] Installing neovim node package..."
    mamba --no-banner run -n neovim --no-capture-output --live-stream npm install -g neovim

    echo "[anjos-mamba] Installing neovim ruby gem..."
    local prefix=$(mamba --no-banner run -n neovim --no-capture-output printenv CONDA_PREFIX)
    mamba --no-banner run -n neovim --no-capture-output --live-stream gem install --bindir ${prefix}/bin neovim

    echo "[anjos-mamba] Installing luarocks package manager..."
    local rocks_version="3.9.2"
    mamba --no-banner run -n neovim --no-capture-output --live-stream curl --location -o luarocks-${rocks_version}.tar.gz https://luarocks.org/releases/luarocks-${rocks_version}.tar.gz
    tar xf luarocks-${rocks_version}.tar.gz
    cd luarocks-${rocks_version}
    mamba --no-banner run -n neovim --no-capture-output --live-stream ./configure --prefix=${prefix} --with-lua=${prefix} --sysconfdir=${prefix}/share/lua/ --rocks-tree=${prefix}
    mamba --no-banner run -n neovim --no-capture-output --live-stream make bootstrap
    cd ..
    rm -rf luarocks-${rocks_version}{,.tar.gz}
}

function anjos-mamba-update {
    _anjos-mamba-update-base
    _anjos-mamba-reinstall-neovim-environment
    _anjos-mamba-reinstall-environments
    _anjos-mamba-cleanup
}
