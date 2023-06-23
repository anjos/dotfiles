# Mounts important Idiap file systems to my mac
# Uses SSHFS, that must be installed via `brew install sshfs`
# SSHFS requires FUSE for macOS, that can be installed from
# https://osxfuse.github.io
function orquidea-mount {
    local host="orquidea"  #shortcut on my ~/.ssh/config for my QNAP NAS

    # Notice $wants/$dest should have the same length
    local wants=()
    local dest=()

    wants+=("/share/CACHEDEV1_DATA")
    dest+=("$HOME/mnt/orquidea")

    local mounted=$(mount)

    for k in "${!wants[@]}"; do
        if [ -z "${mounted##*${dest[$k]}*}" ]; then  #not mounted yet
            echo "[anjos-orquidea] ${host}:${wants[$k]} -> ${dest[$k]} (skip - already mounted)"
        else
            d=$(ssh ${host} "readlink -f ${wants[$k]}")  #figures out real name
            echo "[anjos-orquidea] ${host}:${wants[$k]} -> ${dest[$k]}"
            sshfs "${host}:${d}" "${dest[$k]}"
        fi
    done
}

# Unmounts important orquidea file systems from my mac
function orquidea-unmount {
    local dest=()
    dest+=("$HOME/mnt/orquidea")

    local mounted=$(mount)

    for k in "${dest[@]}"; do
        if [ -z "${mounted##*$k*}" ]; then
            echo "[anjos-orquidea] umount $k"
            umount $k
        else
            echo "[anjos-orquidea] $k is not mounted"
        fi
    done
}
