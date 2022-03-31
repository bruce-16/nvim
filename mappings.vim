"""""""""""""""""""""""""""""""
"键盘映射
"""""""""""""""""""""""""""""""
nnoremap <leader>wq :wq<cr>
nnoremap <leader>w :w<cr> 
nnoremap <leader>q :wq<cr> 
nnoremap <c-n> :nohls<cr>
nnoremap <silent><leader>vp :vsplit<cr>
nnoremap <silent><leader>sp :split<cr>
nnoremap <silent>w+ :vertical resize +10<cr>
nnoremap <silent>w- :vertical resize -10<cr>
nnoremap <silent>w; :resize +5<cr>
nnoremap <silent>w, :resize -5<cr>

nnoremap <silent>gt :tabnext<cr>
nnoremap <silent>gT :tabprevious<cr>

inoremap <c-u> <esc>guiw
inoremap jk <esc>


" reload vimrc
nnoremap <leader>vr :source ~/.config/nvim/init.vim<CR>
"
" 拷贝当前文件路径
function GetCurFileReName()
	let cur_file_name=getreg('%')
	echo "copy      ".cur_file_name."         done"
	call setreg('+',cur_file_name)
endfunction

function GetCurFileAbsoultePath()
	let cur_dir=getcwd()
	let cur_file_name=getreg('%')
	let dir_filename=cur_dir."/".cur_file_name
	echo "copy      ".dir_filename."         done"
	call setreg('+',dir_filename)
endfunction

nnoremap <silent><leader>yp :call GetCurFileReName()<cr>
nnoremap <silent><leader>yP :call GetCurFileAbsoultePath()<cr>


