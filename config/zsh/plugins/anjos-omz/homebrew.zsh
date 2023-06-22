# Functions to bootstrap and update homebrew environments

# Formulas we are interested on having locally
local KEGS=()
KEGS+=('bat')
KEGS+=('coreutils')
KEGS+=('curl')
KEGS+=('direnv')
#KEGS+=('exa')
KEGS+=('fd')
KEGS+=('findutils')
KEGS+=('fzf')
KEGS+=('git')
KEGS+=('git-delta')
KEGS+=('git-filter-repo')
KEGS+=('git-lfs')
KEGS+=('gnu-sed')
KEGS+=('graphviz')
KEGS+=('grep')
KEGS+=('htop')
KEGS+=('imagemagick')
KEGS+=('latexdiff')
KEGS+=('latexindent')
KEGS+=('libyaml')
KEGS+=('neovim')
KEGS+=('openfortivpn')
KEGS+=('pass')
KEGS+=('python@3.9')
KEGS+=('python@3.10')
KEGS+=('ripgrep')
KEGS+=('starship')
KEGS+=('texlab')
KEGS+=('tmux')
KEGS+=('vivid')
KEGS+=('wget')
KEGS+=('zsh')

# New repositories with more packages (beyond homebrew/core and homebrew/cask)
local TAPS=()
TAPS+=('homebrew/cask-fonts')

# Extra formulas to install
local CASKS=()
CASKS+=('balenaetcher')
CASKS+=('font-inconsolata-nerd-font')
CASKS+=('font-jetbrains-mono-nerd-font')
CASKS+=('font-lekton-nerd-font')
CASKS+=('font-meslo-lg-nerd-font')
CASKS+=('font-roboto-mono-nerd-font')
CASKS+=('font-sauce-code-pro-nerd-font')
CASKS+=('font-ubuntu-mono-nerd-font')
CASKS+=('hammerspoon')
CASKS+=('inkscape')
CASKS+=('kitty')
CASKS+=('mactex')
CASKS+=('mattermost')
CASKS+=('qlmarkdown')
CASKS+=('skim')
CASKS+=('syntax-highlight')
CASKS+=('timemachineeditor')
CASKS+=('xquartz')

# The brew binary should be accessible
if ! command -v brew &> /dev/null; then
    echo "brew not installed - not setting up special functions"
    return
fi

# Installs all kegs for the first time
function _anjos-homebrew-install-kegs {
    echo "[anjos-homebrew] Installing required homebrew kegs..."
    brew install "${KEGS[@]}"
}

# Installs all taps for the first time
function _anjos-homebrew-install-taps {
    echo "[anjos-homebrew] Installing required homebrew taps..."
    brew tap "${TAPS[@]}"
}

# Installs all casks for the first time
function _anjos-homebrew-install_casks {
    echo "[anjos-homebrew] Installing required homebrew casks..."
    brew install --cask "${CASKS[@]}"
}

# Installs everything
function anjos-homebrew-install {
    _anjos-homebrew-install-kegs
    _anjos-homebrew-install-taps
    _anjos-homebrew-install-casks
}

function _anjos-homebrew-update-kegs {
    echo "[anjos-homebrew] Updating homebrew..."
    brew update

    echo "[anjos-homebrew] Upgrading homebrew packages..."
    brew upgrade
}

# Updates the current brew/pip/neovim/mamba/conda/omz installations
function _anjos-homebrew-update-casks {
    echo "[anjos-homebrew] Updating homebrew casks..."
    brew upgrade --cask --greedy
}

function _anjos-homebrew-cleanup {
    echo "[anjos-homebrew] Cleaning-up homebrew..."
    brew cleanup
}

function anjos-homebrew-update {
    _anjos-homebrew-update-kegs
    _anjos-homebrew-update-casks
    _anjos-homebrew-cleanup
}
