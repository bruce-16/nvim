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
  source ~/.config/nvim/vscode/general.vim
else
  source ~/.config/nvim/plugins.vim
  source ~/.config/nvim/mappings.vim
  source ~/.config/nvim/general.vim
endif
