# Removes duplicates from PATH and MANPATH
export PATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH)
export MANPATH=$(awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$MANPATH)

# Commands that did not make elsewhere

function git-rm-submodule {
    if [ $# -ne 1 ]; then
      echo "Usage: ${FUNCNAME} <submodule-path>"
      return
    fi

    local MODULE_NAME=${1}
    local MODULE_NAME_FOR_SED=$(echo $MODULE_NAME | sed -e 's/\//\\\//g')

    cat .gitmodules | sed -ne "/^\[submodule \"$MODULE_NAME_FOR_SED\"/,/^\[submodule/!p" > .gitmodules.tmp
    mv .gitmodules.tmp .gitmodules
    git add .gitmodules
    cat .git/config | sed -ne "/^\[submodule \"$MODULE_NAME_FOR_SED\"/,/^\[submodule/!p" > .git/config.tmp
    mv .git/config.tmp .git/config
    git rm --cached $MODULE_NAME
    rm -rf .git/modules/$MODULE_NAME
    rm -rf $MODULE_NAME
}

function rst2pdf {
    local tf=$(tempfile)
    rst2latex $* > ${tf}
    pdflatex ${tf}
    pdflatex ${tf}
    local bname=$(basename ${tf})
    mv ${bname}.pdf $(basename $1 .rst).pdf
    rm -f ${bname}.aux ${bname}.out ${bname}.log
}
