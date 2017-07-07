# dotfiles

## Installation

```
mkdir -p ${HOME}/code/src/github.com/ViBiOh/
cd ${HOME}/code/src/github.com/ViBiOh/
git clone git@github.com:ViBiOh/dotfiles.git
cp dotfiles/bashrc ${HOME}/.bashrc
```

## Vim

For MacOS :

```
brew install vim
sudo ln -s /usr/local/bin/vim /usr/local/bin/vi
```

### Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

Install [CMake](https://cmake.org/download/) for compiling YouCompleteMe suggestions.

For MacOS :

```
brew install cmake
```

Then, you can install YCM.

```
cd ~/.vim/bundle/YouCompleteMe
./install.py --gocode-completer --tern-completer
```
