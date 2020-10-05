![Logos-Screenie](https://cdn.discordapp.com/attachments/690366794346528838/762464651891441664/unknown.png)

# lan-dotfiles
Personal repository for configuration files including vim and tmux.

## Example Install
```
git clone https://github.com/LanHikari22/lan-dotfiles.git ~/src/lan-dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
touch ~/.tmux/defaults.conf
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/src/lan-dotfiles
python3 push.py --only vimrc tmux.conf coc-settings.json
# inside vim: run :PlugInstall to install plugins
# inside tmux: run Ctrl+A Shift+I to install plugins
```
