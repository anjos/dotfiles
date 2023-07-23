# Functions to setup default applications for previewing and opening files

# sets-up all existing extensions
function anjos-duti-setup {
    echo "[anjos-duti] Re-setting default filetype handlers on macOS..."
    local settings=(${_ANJOS_BASEDIR}/duti/settings.txt)
    duti -v ${settings.txt}
}
