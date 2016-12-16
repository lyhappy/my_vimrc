# my_vimrc

## Clone me

```
$ git clone https://github.com/lyhappy/my_vimrc.git
$ mv ~/.vimrc ./old_vimrc
$ mv my_vimrc/vimrc ~/.vimrc
```

## Install Vundle

```
$ mkdir ~/.vim/bundle
$ cd ~/.vim/bundle/
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Auto Download & Install Plugins
Start vim, and execute the command `:BundleInstall`.

## Compile and Install YouCompleteMe

```
$ cd ~/.vim/bundle/YouCompleteMe/
$ ./install.py --clang-completer
```

## Ctags (on Mac OS)

A Exuberant Ctags should be installed first on Mac OS.

```
$ brew install ctags
```

And the default location where brew installs its packages is "usr/local/bin/", so edit .vimrc and let:

```
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
```

### Installed Plugins:
>
Plugin 'gmarik/vundle'<br>
Plugin 'scrooloose/nerdtree'<br>
Plugin 'bling/vim-airline'<br>
Plugin 'majutsushi/tagbar'<br>
Plugin 'Valloric/YouCompleteMe'<br>
Plugin 'dracula/vim'<br>
Plugin 'scrooloose/syntastic'<br>
Plugin 'nvie/vim-flake8'<br>
Plugin 'mru.vim'
Plugin 'Visual-Mark'
Plugin 'minibufexpl.vim'
Plugin 'gtags.vim'

