# Functions to bootstrap and update MacOS SDKs

# Only executed on macOS
if [ "$(uname)" != "Darwin" ]; then
    return 1
fi

_ANJOS_MACOS_SDK="/opt/MacOSX11.0.sdk"  # required on macbooks with Apple silicon

if [ -r ${_ANJOS_MACOS_SDK} ]; then
    export OSX_SDK_DIR="$(dirname ${_ANJOS_MACOS_SDK})"

    function anjos-macos-sdk-deinit {
        echo "[anjos-macos-sdk] Removing \`${_ANJOS_MACOS_SDK}\` (requires sudo)..."
        sudo rm -rf ${_ANJOS_MACOS_SDK}
    }

else
    echo "[anjos-macos-sdk] Cannot find \`${_ANJOS_MACOS_SDK}\`, not setting up \$\{OSX_SDK_DIR\}..."
    echo "[anjos-macos-sdk-init] Run \`anjos-macos-sdk-init\` to install it"

    # Installs macOS development kit required for conda builds
    function anjos-macos-sdk-init {
        local sdk_ext=".tar.xz"
        local sdk_base=$(basename ${_ANJOS_MACOS_SDK})
        local sdk_dest=$(dirname ${_ANJOS_MACOS_SDK})
        echo "[anjos-macos-sdk] Installing \`${sdk_base}\` at \`${sdk_dest}\` (requires sudo)..."
        curl -L -O "https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/${sdk_base}${sdk_ext}"
        sudo tar xf ${sdk_base}${sdk_ext} -C ${sdk_dest}
        rm -f ${sdk_base}${sdk_ext}
        sudo chown -R ${USER}:admin ${_ANJOS_MACOS_SDK}
    }
fi
