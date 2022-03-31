"""""""""""""""""""""""""""""""
"插件管理，使用vim-plug。 https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
"Plug 'morhetz/gruvbox' "主题
Plug 'kaicataldo/material.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" motion
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
"markdown预览插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" js & ts
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" lightline
Plug 'itchyny/lightline.vim'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
" 注释插件
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/vim-jsx-improve', { 'for': ['javascript', 'typescript'] }
" 自动补充括号的插件
Plug 'raimondi/delimitMate'
" git 插件
" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" 欢迎主页插件
Plug 'mhinz/vim-startify'
" lazygit
Plug 'kdheepak/lazygit.nvim'

call plug#end()

" =====
" ===== coc
" =====
" 禁止提示
" let g:coc_disable_startup_warning = 0
"
set updatetime=100
set shortmess+=c
set cmdheight=2
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc plugins
let g:coc_global_extensions = [
			\'coc-snippets',
			\'coc-lists',
			\'coc-yank',
			\'coc-json',
			\'coc-tsserver',
      \'coc-tslint',
			\'coc-highlight',
			\'coc-reason',
      \'coc-vimlsp',
      \'coc-marketplace',
      \'coc-rls',
      \'coc-rust-analyzer',
      \'coc-explorer',
      \'coc-git',
			\]

command! OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>] <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>tt :CocCommand explorer<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" =====
" ===== lightline
" =====
let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'currentStatus', 'filename', 'modified' ] ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'blame': 'LightlineGitBlame',
  \   'currentStatus': 'LightlineGitStatus',
  \ },
  \ }

function! LightlineGitStatus() abort
  let status = get(b:, 'coc_git_status', '')
  " return status
  return status
endfunction

function! LightlineGitBlame() abort
	let blame = get(b:, 'coc_git_blame', '')
	" return blame
	return winwidth(0) > 120 ? blame : ''
endfunction

" ====
" ==== vim-jsx-improve
" ====
let g:jsx_improve_motion_disable = 1

" ====
" ==== startify
" ====
let g:startify_lists = [
			\ { 'type': 'files',     'header': ['   MRU']            },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]

" ====
" ==== colorscheme
" ====
" 设置主题
" colorscheme gruvbox
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
"let g:material_theme_style = 'palenight'
"colorscheme space_vim_theme
set background=light
let $BAT_THEME='OneHalfLight'
colorscheme onehalflight

" ===
" === FZF
" ===
"noremap <silent> <leader>p :GFiles<CR>
"noremap <silent> <leader>fb :Buffers<CR>
noremap <silent> <leader>fh :History<CR>
noremap <silent> <leader>fl :Lines<CR>
let g:fzf_preview_window = ['up:45%', 'ctrl-/']
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

function! s:list_buffers()
 redir => list
 silent ls
 redir END
 return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
 execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" rg 普通搜索，exclude node_modules，git
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --glob "!{node_modules/*,.git/*}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
"noremap <silent> <leader>fs :Rg<CR>

" rg 完整单词搜索
function! RipgrepFzfWord(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -w --smart-case --glob "!{node_modules/*,.git/*}" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rgw call RipgrepFzfWord(<q-args>, <bang>0)
noremap <silent> <leader>fsw :Rgw<CR>

" rg 正则搜索
function! RipgrepFzfRegex(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -e --glob "!{node_modules/*,.git/*}" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rge call RipgrepFzfRegex(<q-args>, <bang>0)
noremap <silent> <leader>fse :Rgw<CR>

" command! BD call fzf#run(fzf#wrap({
  " \ 'source': s:list_buffers(),
  " \ 'sink*': { lines -> s:delete_buffers(lines) },
  " \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
" \ }))

" noremap <leader>d :BD<CR>


"
" ===
" === telescope
" ===
lua << EOF
require('telescope').setup({
  defaults = {
    layout_config = { width = 0.9 },
    wrap_results = 1,
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
    marks = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  }
})

require('telescope').load_extension('fzf')
EOF

"nnoremap <Leader>ff :lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy())<cr>
noremap <leader>p :Telescope git_files<cr>
"nnoremap <leader>ff :Telescope grep_string<cr>
nnoremap <leader>fs :Telescope live_grep<cr>
nnoremap <leader>fb :lua require'telescope.builtin'.buffers(require('telescope.themes').get_ivy())<cr>
nnoremap <leader>fm :lua require'telescope.builtin'.marks(require('telescope.themes').get_ivy())<cr>
"nnoremap <leader>fr :lua require'telescope.builtin'.treesitter(require('telescope.themes').get_ivy())<cr>
" git 
nnoremap <leader>gs :lua require'telescope.builtin'.git_status(require('telescope.themes').get_ivy())<cr>

" ===
" === lazygit
" ===
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 0 " fallback to 0 if neovim-remote is not installed

nnoremap <silent> <leader>gg :LazyGit<CR>
