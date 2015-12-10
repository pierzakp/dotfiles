# Dotfiles

## Installation

In order to install those config files you need to:

```bash
cd ~/src
git clone git@github.com:pierzakp/dotfiles.git
ln -s ~/src/dotfiles/vimrc ~/.vimrc
ln -s ~/src/dotfiles/vim ~/.vim
ln -s ~/src/dotfiles/gitconfig ~/.gitconfig
ln -s ~/src/dotfiles/gitignore ~/.gitignore
ln -s ~/src/dotfiles/tmux.conf ~/.tmux.conf
lns -s ~/src/dotfiles/zshrc_aliases ~/.zshrc_aliases
git clone git@github.com:gmarik/Vundle.vim.git ~/.vim/bundle/vundle
vim +PluginInstall +qall
```

## Post Installation

Add on the beggining of your ~/.zshrc:

```bash
source .zshrc_aliases
```
