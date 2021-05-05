#!/bin/bash

# moves here and gets config
cd $(dirname $0)
source ./config.sh
cd ../

read -p "link dotfiles of ${PACKAGES[*]}? (y/n): " yn
case ${yn} in
    [yY]*)
        sh ./etc/link_dotfiles.sh \
            && echo ok: done linking dotfiles \
            || echo failed: undone linking dotfiles
        ;;
    *)
        :
        ;;
esac

read -p "install homebrew ${PACKAGES[*]}? (y/n): " yn
case ${yn} in
    [yY]*)
        sh ./etc/install_packages.sh \
            && echo ok: done installing packages \
            || echo failed: undone installing packages
        ;;
    *)
        :
        ;;
esac

read -p "install vim-plug & vim plugins? (y/n): " yn
case ${yn} in
    [yY]*)
        sh ./etc/install_vim_plugins.sh \
            && echo ok: done installing vim plugins \
            || echo failed: undone installing vim plugins
        ;;
    *)
        :
        ;;
esac

echo info: done all processes!
