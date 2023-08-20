#!/bin/bash

if ! [ -f ./brew_pckgs.sh ]
then
    echo "No packages found..."
    exit 1
fi

source ./brew_pckgs.sh

if ! command -v brew &> /dev/null
then
    echo "could not find homebrew... please install"
    exit 1
else
    echo "starting to install packages"
    echo brew update && brew upgrade
    for formula in ${FORMULAS[@]} 
    do
       brew install ${formula}
    done
fi

if [ -f ./install_nerdfonts.sh ]
then
    echo "installing nerdfonts"
    ./install_nerdfonts.sh
fi

echo "done..."
