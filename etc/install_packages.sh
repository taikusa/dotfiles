#!/bin/bash

# moves here and gets config
cd $(dirname $0)
source ./config.sh
cd ../

# check and install brew
if [ -x $(which brew) ]
then
    echo info: homebrew is installed
else
    echo info: install homebrew...
    # copied from https://brew.sh/index_ja
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install commands (uninstalled) based on config.sh
for command in ${COMMANDS[@]}
do
    if [ -x $(which ${command}) ]
    then
        echo info: ${command} is installed
    else
        echo info: install ${command} with homebrew...
        brew install ${command} \
            && echo ok: ${command} installed \
            || echo failed: ${command} could not be installed
    fi
done

# install packages (uninstalled) based on config.sh
for package in ${PACKAGES[@]}
do
    if [ -x $(which ${package}) ]
    then
        echo info: ${package} is installed
    else
        echo info: install ${package} with homebrew...
        brew install ${package} \
            && echo ok: ${package} installed \
            || echo failed: ${package} could not be installed
    fi
done

# TODO: brew version >= 0.5
