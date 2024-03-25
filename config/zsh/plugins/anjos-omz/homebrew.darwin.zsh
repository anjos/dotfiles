# Functions to bootstrap and update homebrew environments

_ANJOS_HOMEBREW_PREFIX="/opt/homebrew"

# The brew binary should be accessible
if [ -f ${_ANJOS_HOMEBREW_PREFIX}/bin/brew ]; then
    eval "$(${_ANJOS_HOMEBREW_PREFIX}/bin/brew shellenv)"

    function anjos-homebrew-deinit {
        echo "[anjos-homebrew] Completely erasing homebrew installation. Hold your horses..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
        echo "[anjos-homebrew] Remember to unset any eventual zshrc initialisations you put in place."
    }
else
    echo "[anjos-homebrew] Cannot find \`${_ANJOS_HOMEBREW_PREFIX}/bin/brew\`, not setting up homebrew paths..."
    echo "[anjos-homebrew] Run \`anjos-homebrew-init\` to install it"

    # Installs homebrew for the first time
    function anjos-homebrew-init {
        echo "[anjos-homebrew] Installing homebrew from official web sources..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "[anjos-homebrew] Restart your shell so the command \`brew\` can be accessed"
        echo "[anjos-homebrew] Then, run \`anjos-homebrew-install\` to install all packages"
        echo "[anjos-homebrew] Use \`anjos-homebrew-update\` to keep the install up to date"
    }

    return
fi

# Installs all kegs for the first time
function _anjos-homebrew-install-kegs {
    # Formulas we are interested on having locally
    local kegs=()
    kegs+=('direnv')
    kegs+=('duti')  # sets default macos apps from cmdline
    kegs+=('findutils')
    kegs+=('libyaml')
    kegs+=('neovim')
    kegs+=('openfortivpn')
    kegs+=('pass')
    kegs+=('python@3.11')
    kegs+=('wget')
    kegs+=('zsh')

    echo "[anjos-homebrew] Installing required homebrew kegs..."
    brew install "${kegs[@]}"
}

# Installs all taps for the first time
function _anjos-homebrew-install-taps {
    # New repositories with more packages (beyond homebrew/core and homebrew/cask)
    local taps=()
    taps+=('homebrew/cask-fonts')

    echo "[anjos-homebrew] Installing required homebrew taps..."
    brew tap "${taps[@]}"
}

# Installs all casks for the first time
function _anjos-homebrew-install_casks {
    # Extra formulas to install
    local casks=()
    casks+=('balenaetcher')
    #casks+=('betterdisplay')
    casks+=('font-inconsolata-nerd-font')
    casks+=('font-jetbrains-mono-nerd-font')
    casks+=('font-lekton-nerd-font')
    casks+=('font-meslo-lg-nerd-font')
    casks+=('font-roboto-mono-nerd-font')
    casks+=('font-sauce-code-pro-nerd-font')
    casks+=('font-ubuntu-mono-nerd-font')
    casks+=('hammerspoon')
    casks+=('inkscape')
    casks+=('kitty')
    casks+=('mactex')
    casks+=('mattermost')
    casks+=('qlmarkdown')
    casks+=('skim')
    casks+=('syntax-highlight')
    casks+=('timemachineeditor')
    casks+=('xquartz')

    echo "[anjos-homebrew] Installing required homebrew casks..."
    brew install --cask "${casks[@]}"
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

# Updates the current homebrew installations
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
