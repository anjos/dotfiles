# A function to start a new tunnel to my machine at Idiap
function idiap-remote-desktop-macos {
  if [[ $1 == "-h" ]]; then
    echo "Enables a remote desktop to an idiap mac ci:"
    echo "$ rdmac"
    echo "$ rdmac <num>"
    echo "$ rdmac <num> <port>"
    echo ""
    echo "# <num>:"
    echo "#   1 - m1 mac mini"
    echo "#   default = 1"
    echo ""
    echo "# <port> is the local port to bind to (default 5900)"
    return 1
  fi
  local target="beatmacosx02"
  local port="5900"
  if [[ $# -ge 1 ]]; then
      if [[ $1 == 1 ]]; then
          local target="beatmacosx02"
      else
          echo "choose <num> to be 1"
          return
      fi
  fi
  if [[ $# == 2 ]]; then
      local port=$2
  fi
  cmd="ssh -N -L ${port}:${target}.lab.idiap.ch:5900 idiap"
  echo "tunnel: $cmd"
  eval $cmd
}

# This starts a VPN tunnel to Idiap
function idiap-vpn {
    sudo openfortivpn sslvpn.idiap.ch:443 --username=aanjos --trusted-cert 36e9b7ab8fac6699da2f617a58b4fb32e140a62352bcde30569d6a5ea09d0b4e --pppd-use-peerdns=1
}

# Mounts important Idiap file systems to my mac
# Uses SSHFS, that must be installed via `brew install sshfs`
# SSHFS requires FUSE for macOS, that can be installed from
# https://osxfuse.github.io
function idiap-mount {
    local host="idiap"  #shortcut on my ~/.ssh/config for my Idiap login

    # Notice $mount/$dest should have the same length
    local mount=()
    local dest=()

    mount+=("/idiap/temp/aanjos")
    dest+=("$HOME/mnt/idiap/temp")

    mount+=("/idiap/user/aanjos")
    dest+=("$HOME/mnt/idiap/user")

    mount+=("/idiap/home/aanjos")
    dest+=("$HOME/mnt/idiap/home")

    local mounted=$(mount)

    for k in "${!mount[@]}"; do
        if [ -z "${mounted##*${dest[$k]}*}" ]; then  #not mounted yet
            echo "[anjos-idiap] ${host}:${mount[$k]} -> ${dest[$k]} (skip - already mounted)"
        else
            d=$(ssh ${host} "readlink ${mount[$k]}")  #figures out real name
            echo "[anjos-idiap] ${host}:${mount[$k]} -> ${dest[$k]}"
            sshfs "${host}:${d}" "${dest[$k]}"
        fi
    done
}

# Unmounts important Idiap file systems from my mac
function idiap-unmount {

    local dest=()

    dest+=("$HOME/mnt/idiap/temp")
    dest+=("$HOME/mnt/idiap/user")
    dest+=("$HOME/mnt/idiap/home")

    local mounted=$(mount)

    for k in "${dest[@]}"; do
        if [ -z "${mounted##*$k*}" ]; then
            echo "umount $k"
            umount $k
        else
            echo "$k is not mounted"
        fi
    done

}
