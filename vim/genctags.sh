#!/bin/bash 
# Created by Andre Anjos <andre.dos.anjos@cern.ch>
# Qua 13 Fev 2008 13:47:51 CET

# Generates 'ctags' for a given project hierarchy

# A few variables you can configure
DEST=${HOME}/.vim/tags
OPT="--recurse --totals --exclude=@ctags-exclude.txt"

if [ $# != 2 ]; then
  echo "usage: $0 <project-name> <base-directory>+"
  exit 1
fi

[ ! -d ${DEST} ] && mkdir -pv ${DEST}
ctags ${OPT} -f ${DEST}/$1.tags $2
exit $?
