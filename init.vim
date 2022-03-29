let g:mapleader = "\<Space>"

"""""""""""""""""""""""""""""""
" nvim 设置
"
let g:python3_host_prog="/usr/local/bin/python3.9"
let g:python_host_prog="/usr/bin/python2.7"

if !has('nvim')
    set ttymouse=xterm2
endif


if exists('g:vscode')
  source ~/.dotfiles/vim/vscode/general.vim
else
  source ~/.dotfiles/vim/plugins.vim
  source ~/.dotfiles/vim/mappings.vim
  source ~/.dotfiles/vim/general.vim
endif
