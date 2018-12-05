# !/bin/bash

SUBMODULE_FILE=".gitmodules"

if [ $1 == "commit" ] ;then
    if [ -f ${SUBMODULE_FILE} ];then
        echo "has"
    else
        echo "no"
    fi
    echo "commit"
fi