
 set nocompatible              " 去除VI一致性,必須
 set clipboard+=unnamed "使用系统剪切板
 set showmode " 在底部显示，当前处于命令模式还是插入模式。
 set nobackup "不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）。
 set hidden "隐藏 buffer

 set noswapfile "不创建交换文件
 set undofile "保留撤销文件
 set noerrorbells "出错时，不要发出响声。

set visualbell "出错时，发出视觉提示，通常是屏幕闪烁。
 set history=1000 "Vim 需要记住多少次历史操作。

"打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。set autoread "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。
" set autoread

set wildmenu "设置补全 ex 命令的模式，以 list 形式显示
set wildmode=full

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
set relativenumber "显示相对行号
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
" set fileencoding=utf-8

"搜索设置
set showmatch "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号。
set hlsearch "搜索时，高亮显示匹配结果。
set incsearch "输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果。
set ignorecase "搜索时忽略大小写。
set smartcase "如果同时打开了ignorecase，那么对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感。比如，搜索Test时，将不匹配test；搜索test时，将匹配Test。

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100
" don't give |ins-completion-menu| messages.
set shortmess+=c


" fzf
set rtp+=/usr/local/opt/fzf

" autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
"autocmd FileType json setlocal ts=4 sts=4 sw=4

