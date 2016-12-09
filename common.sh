#! /bin/bash
sudo apt-get install emacs tmux git python-pip build-essential
if [ -e ~/.emacs.d ]; then
    echo "-------- Create .emacs.d backup --------"
    cp -r ~/.emacs.d ~/.emacs.d.backup
    rm -rf ~/.emacs.d
fi
cp -r ./dotfiles/emacs.d ~/.emacs.d

if [ -e ~/.emacs.d ]; then
    echo "-------- Create .emacs.d backup --------"
    cp -r ~/.tmux.conf ~/.tmux.conf.backup
    rm -rf ~/.tmux.conf
fi
cp -r ./dotfiles/tmux.conf ~/.tmux.conf
