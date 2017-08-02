#! bash
mkdir ~/.vim/bundle/ -p
cd ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

# in vim
# :PluginInstall
# ctags for tagbar
