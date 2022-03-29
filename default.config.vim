"系统设置
set nocompatible              " 去除VI一致性,必須
set clipboard+=unnamed "使用系统剪切板
set showmode " 在底部显示，当前处于命令模式还是插入模式。
set nobackup "不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）。
set noswapfile "不创建交换文件
set undofile "保留撤销文件
set noerrorbells "出错时，不要发出响声。
"set visualbell "出错时，发出视觉提示，通常是屏幕闪烁。
set history=1000 "Vim 需要记住多少次历史操作。
set autoread "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。set autoread "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。
au FocusGained * :checktime
set wildmenu "设置补全 ex 命令的模式，以 list 形式显示
set wildmode=full

"""""""""""""""""""""""""""""""
" nvim 设置
"
let g:coc_disable_startup_warning = 1
let g:python3_host_prog="/usr/local/bin/python3"
let g:python_host_prog="/usr/bin/python2.7"
if !has('nvim')
    set ttymouse=xterm2
endif

"""""""""""""""""""""""""""""""
"插件管理，使用vim-plug。 https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"Plug 'morhetz/gruvbox' "主题
Plug 'kaicataldo/material.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
"markdown预览插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'itchyny/lightline.vim'
" Initialize plugin system
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
" 注释插件
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/vim-jsx-improve', { 'for': ['javascript', 'typescript'] }
" 自动补充括号的插件
Plug 'raimondi/delimitMate' 
" git 插件
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 欢迎主页插件
Plug 'mhinz/vim-startify'
call plug#end()

"视图设置
syntax on  "开启语法高亮
set ruler "显示标尺 
set showcmd "输入的命令显示出来，看的清楚些 
set cmdheight=1 "命令行（在状态行下）的高度，设置为1 
set laststatus=1 "启动显示状态行(1),总是显示状态行(2) 
set foldenable "允许折叠 
set foldmethod=manual "手动折叠 
"set background=dark "背景使用黑色
set number "显示行号
"set relativenumber "显示相对行号
"filetype indent on "设置不同文件自动缩进
set cursorline "高亮当前行
"set nowrap "关闭自动折行
set  ruler "在状态栏显示光标的当前位置（位于哪一行哪一列）。
set laststatus=2 "是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示。

" 编辑设置
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set nrformats=

" 设置主题
"colorscheme gruvbox
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'palenight'
let g:lightline = { 'colorscheme': 'material_vim' }
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material
" 显示中文帮助
if version >= 603
set helplang=cn
set encoding=utf-8
endif

" 设置编码方式
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"搜索设置
set showmatch "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号。
set hlsearch "搜索时，高亮显示匹配结果。
set incsearch "输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果。
set ignorecase "搜索时忽略大小写。
set smartcase "如果同时打开了ignorecase，那么对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感。比如，搜索Test时，将不匹配test；搜索test时，将匹配Test。


""""""""""""""""""""""""""""""""
" 插件配置
""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""
"键盘映射
"""""""""""""""""""""""""""""""
let mapleader = "\<space>"

nnoremap <leader>wq :wq<CR>
nnoremap <leader>w :w<CR> 
nnoremap <leader>q :wq<CR> 
nnoremap <c-n> :nohls<CR>
" markdown-preview "
nnoremap <leader>mp :MarkdownPreview<cr>
nnoremap <leader>mps :MarkdownPreviewStop<cr>
nnoremap <leader>mpt :MarkdownPreviewToggle<cr>
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <silent><leader>vp :vsplit<cr>
nnoremap <silent><leader>sp :split<cr>
nnoremap <silent>w+ :vertical resize +10<cr>
nnoremap <silent>w- :vertical resize -10<cr>
nnoremap <silent>w; :resize +5<cr>
nnoremap <silent>w, :resize -5<cr>

inoremap <c-u> <esc>gUiw
inoremap jk <esc>

vnoremap <c-u> gU

autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
"autocmd FileType json setlocal ts=4 sts=4 sw=4

"========= coc
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [
            \'coc-snippets',
            \'coc-lists',
            \'coc-yank',
            \'coc-json',
            \'coc-tsserver',
            \'coc-json',
            \'coc-highlight',
            \'coc-reason'
            \]
vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
nmap <silent> <leader>h :call CocAction('doHover')<CR>
command! OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <f2> <Plug>(coc-rename)

nnoremap <leader>f :CocList --auto-preview grep<space>
nnoremap <leader>r :CocList --auto-preview outline<CR>
" Remap for format selected region
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>fi  <Plug>(coc-fix-current)

nnoremap <silent> <leader>p :CocList files<CR>
nnoremap <silent> <leader>b :CocList buffers<CR>
nnoremap <silent> <leader>y :CocList -A --normal yank<cr>
nnoremap <silent> <leader>gf :exe 'CocList --auto-preview grep '.expand('<cword>')<CR>
nnoremap <silent> <leader>cw :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

"autocmd Filetype rust,python,go,c,cpp setl omnifunc=lsp#omnifunc
"nnoremap <silent> <leader>cj :call lsp#text_document_definition()<CR>
"nnoremap <silent> <leader>ch  :call lsp#text_document_hover()<CR>

"===== lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'currentBranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'LightlineGitBlame',
      \   'currentBranch': 'fugitive#head',
      \ },
      \ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

"===== defx 配置
map <silent> - :Defx -columns=git:indent:icons:filename:type<CR>
call defx#custom#option('_', {
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'direction': 'botright',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'tree',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop',)
  nmap <silent><buffer><expr> <2-LeftMouse>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop',)
  " 目录定位到当前文件位置
  nnoremap <silent><leader>dc :Defx<CR> :<C-u>:Defx -columns=git:indent:icons:filename:type -search=`expand('%:p')` `getcwd()`<CR> <c-w>l<CR>

  nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
  nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> C defx#do_action('copy')
  nnoremap <silent><buffer><expr> P defx#do_action('paste')
  nnoremap <silent><buffer><expr> M defx#do_action('rename')
  nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

" Defx git
let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1

" vim-jsx-improve
let g:jsx_improve_motion_disable = 1

" 拷贝当前文件路径
function GetCurFileRelativePath()
    let cur_file_name=getreg('%')
    echo "copy      ".cur_file_name."         done"
    call setreg('+',cur_file_name)
endfunction

function GetCurFileAbsoultePath()
  let cur_dir=getcwd()
  let cur_file_name=getreg('%')
  let dir_filename=cur_dir."".cur_file_name
  echo "copy      ".dir_filename."         done"
  call setreg('+',dir_filename)
endfunction

nnoremap <silent><f9> :call GetCurFileRelativePath()<cr>
nnoremap <silent><f8> :call GetCurFileRelativePath()<cr>
" 注释插件配置
let NERDSpaceDelims=1

let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

nnoremap <leader>cd :cd ~/Documents/workspace/gitspace/bear-web<cr>

