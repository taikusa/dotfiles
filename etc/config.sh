#!/bin/bash

readonly PACKAGES=(git nvim ideavim tmux zsh)
readonly IGNORES=(etc README.md)

readonly GITCONFIG_PATH=$HOME/.gitconfig
readonly INITVIM_PATH=$HOME/.config/nvim/init.vim # or $HOME/.local/share/nvim/init.vim
readonly IDEAVIMRC_PATH=$HOME/.ideavimrc
readonly TMUXCONF_PATH=$HOME/.tmux.conf
readonly ZSHRC_PATH=$HOME/.zshrc

readonly COMMANDS=(shuf ccat)
