# Adds our own executables in front of the path
if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Removes duplicates from PATH and MANPATH
export PATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH)
export MANPATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$MANPATH)
