<div align="center">
  TODO library
  <p>TODO description</p>
</div>

<p align="center">
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-brightgreen.svg"
      alt="License: MIT" />
  </a>
  <a href="https://buymeacoffee.com/lan22h">
    <img src="https://img.shields.io/static/v1?label=Buy me a coffee&message=%E2%9D%A4&logo=BuyMeACoffee&link=&color=greygreen"
      alt="Buy me a Coffee" />
  </a>
</p>

<div align="center">
  <sub>Built with ❤︎ by Mohammed Alzakariya
</div>
<br>

- [lan-dotfiles](#lan-dotfiles)
  - [Example Install (install.sh)](#example-install-installsh)
- [Running config tool](#running-config-tool)

# lan-dotfiles
Personal repository for configuration files including vim and tmux.

## Example Install (install.sh)
```
git clone https://github.com/LanHikari22/lan-dotfiles.git ~/src/lan-dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
touch ~/.tmux/defaults.conf
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/src/lan-dotfiles
python3 push.py --only vimrc tmux.conf coc-settings.json
# inside vim: run :PlugInstall to install plugins
vim -E -c PlugInstall -c q -c q
# inside tmux: run Ctrl+A Shift+I to install plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# installing node.js for coc in vim
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
```

# Running config tool

Use `BIN=BIN_NAME ./run.sh` where `BIN_NAME` can be `diff`, `push`, and `pull`. 

Expects a `location.txt` in directory ran. This just maps key values `key: value`, and allows comment lines with `//` or empty lines.

The `key` is the location of the dot file in the current directory, and the `value` is the system location.