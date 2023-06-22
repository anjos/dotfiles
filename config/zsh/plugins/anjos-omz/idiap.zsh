# A function to start a new tunnel to my machine at Idiap
function rdmac () {
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
function vpn() {
    sudo openfortivpn sslvpn.idiap.ch:443 --username=aanjos --trusted-cert 36e9b7ab8fac6699da2f617a58b4fb32e140a62352bcde30569d6a5ea09d0b4e --pppd-use-peerdns=1
}
