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

# check and install shuf
if [ -x $(which shuf) ]
then
    echo info: shuf is installed
else
    echo info: install shuf...
    brew install coreutils
fi

# install packages (uninstalled) based on config.sh
for packages in ${PACKAGES[@]}
do
    if [ -x $(which ${packages}) ]
    then
        echo info: ${packages} is installed
    else
        echo info: install ${packages} with homebrew...
        brew install ${packages} \
            && echo ok: ${packages} installed \
            || echo failed: ${packages} could not be installed
    fi
done
