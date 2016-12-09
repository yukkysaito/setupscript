#! /bin/bash
cd ~/
sudo apt-get install python-pip
git clone https://github.com/milkbikis/powerline-shell
cd powerline-shell
cp ./config.py.dist ./config.py
./install.py
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py
pip install argparse
cd ~
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ~

echo "function _update_ps1() {
    PS1=\"\$(~/powerline-shell.py \$? 2> /dev/null)\"
}

if [ \"\$TERM\" != \"linux\" ]; then
    PROMPT_COMMAND=\"_update_ps1; \$PROMPT_COMMAND\"
fi" >> ~/.bashrc
