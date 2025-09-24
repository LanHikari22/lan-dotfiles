#!/bin/sh

echo "This script requires some manual steps. See comments."

# install tmp for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# manual:
# to install plugins: prefix - I. Update them with prefix - U.

# Get vim.plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# manual:
# in vim, run :PlugInstall to install plugins.

touch ~/.vimrc.local

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# manual:
# Then in a new terminal run
# nvm install node

