#!/bin/bash

# check and install brew
if [ -e ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim ]
then
    echo info: vim-plug is installed
else
    echo info: install vim-plug...
    # copied from https://github.com/junegunn/vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
