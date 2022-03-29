let mapleader = "\<space>"

" vscode 设置
function! s:vscodeFormat(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.formatSelection", line1, line2, 0)
endfunction

function! s:vscodeCommentary(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
endfunction

function! s:vscodeGoToDefinition()
    if exists('b:vscode_controlled') && b:vscode_controlled
        exe "normal! m'"
        call VSCodeNotify("editor.action.revealDefinition")
    else
        " Allow to funcionar in help files
        exe "normal! \<C-]>"
    endif
endfunction

function! s:hover()
  normal! gv
  call VSCodeNotify('editor.action.showHover')
endfunction

function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1) else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

command! -range -bar VSCodeCommentary call s:vscodeCommentary(<line1>, <line2>)

xnoremap <expr> <Plug>VSCodeCommentary <SID>vscodeCommentary()
nnoremap <expr> <Plug>VSCodeCommentary <SID>vscodeCommentary()
nnoremap <expr> <Plug>VSCodeCommentaryLine <SID>vscodeCommentary() . '_'

" Bind format to vscode format selection
xnoremap <expr> = <SID>vscodeFormat()
nnoremap <expr> = <SID>vscodeFormat()
nnoremap <expr> == <SID>vscodeFormat() . '_'

" gf/gF . Map to go to definition for now
nnoremap <silent> gf :<C-u>call <SID>vscodeGoToDefinition()<CR>
nnoremap <silent> gd :<C-u>call <SID>vscodeGoToDefinition()<CR>
nnoremap <silent> gh :<C-u>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap <silent> <C-]> :<C-u>call <SID>vscodeGoToDefinition()<CR>
nnoremap <silent> gF :<C-u>call VSCodeNotify('editor.action.peekDefinition')<CR>
nnoremap <silent> gD :<C-u>call VSCodeNotify('editor.action.peekDefinition')<CR>

xnoremap <silent> gf :<C-u>call <SID>vscodeGoToDefinition()<CR>
xnoremap <silent> gd :<C-u>call <SID>vscodeGoToDefinition()<CR>
xnoremap <silent> gh :<C-u>call <SID>hover()<CR>
xnoremap <silent> <C-]> :<C-u>call <SID>vscodeGoToDefinition()<CR>
xnoremap <silent> gF :<C-u>call VSCodeNotify('editor.action.peekDefinition')<CR>
xnoremap <silent> gD :<C-u>call VSCodeNotify('editor.action.peekDefinition')<CR>
" <C-w> gf opens definition on the side
nnoremap <silent> <C-w>gf :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
nnoremap <silent> <C-w>gd :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
nnoremap <silent> <C-w>gF :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
xnoremap <silent> <C-w>gf :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
xnoremap <silent> <C-w>gd :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
xnoremap <silent> <C-w>gF :<C-u>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
xnoremap <expr> <C-/> <SID>vscodeCommentary()
nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Workaround for gk/gj
nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

" workaround for calling command picker in visual mode
xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>


call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

call plug#end()


" tab
function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
        call VSCodeCall(direction == 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
endfunction

command! -complete=file -nargs=? Tabedit if <q-args> == '' | call VSCodeNotify('workbench.action.quickOpen') | else | call VSCodeExtensionNotify('open-file', expand(<q-args>), 0) | endif
command! -complete=file Tabnew call VSCodeExtensionNotify('open-file', '__vscode_new__', 0)
command! Tabfind call VSCodeNotify('workbench.action.quickOpen')
command! Tab echoerr 'Not supported'
command! Tabs echoerr 'Not supported'
command! -bang Tabclose if <q-bang> == '!' | call VSCodeNotify('workbench.action.revertAndCloseActiveEditor') | else | call VSCodeNotify('workbench.action.closeActiveEditor') | endif
command! Tabonly call VSCodeNotify('workbench.action.closeOtherEditors')
command! -nargs=? Tabnext call <SID>switchEditor(<q-args>, 'next')
command! -nargs=? Tabprevious call <SID>switchEditor(<q-args>, 'prev')
command! Tabfirst call VSCodeNotify('workbench.action.firstEditorInGroup')
command! Tablast call VSCodeNotify('workbench.action.lastEditorInGroup')
command! Tabrewind call VSCodeNotify('workbench.action.firstEditorInGroup')
command! -nargs=? Tabmove echoerr 'Not supported yet'

AlterCommand tabe[dit] Tabedit
AlterCommand tabnew Tabnew
AlterCommand tabf[ind] Tabfind
AlterCommand tab Tab
AlterCommand tabs Tabs
AlterCommand tabc[lose] Tabclose
AlterCommand tabo[nly] Tabonly
AlterCommand tabn[ext] Tabnext
AlterCommand tabp[revious] Tabprevious
AlterCommand tabr[ewind] Tabrewind
AlterCommand tabfir[st] Tabfirst
AlterCommand tabl[ast] Tablast
AlterCommand tabm[ove] Tabmove

" <C-u> is needed to clear prev count
nnoremap <silent> gt :<C-U>call <SID>switchEditor(v:count, 'next')<CR>
xnoremap <silent> gt :<C-U>call <SID>switchEditor(v:count, 'next')<CR>
nnoremap <silent> gT :<C-U>call <SID>switchEditor(v:count, 'prev')<CR>
xnoremap <silent> gT :<C-U>call <SID>switchEditor(v:count, 'prev')<CR>

" file
function! s:editOrNew(...)
    let file = a:1
    let bang = a:2

    if file == ''
        if bang == '!'
            call VSCodeNotify('workbench.action.files.openFile')
        else
            call VSCodeNotify('workbench.action.quickOpen')
        endif
    else
        " Last arg is to close previous file, e.g. e! ~/blah.txt will open blah.txt instead the current file
        call VSCodeExtensionNotify('open-file', expand(file), bang == '!' ? 1 : 0)
    endif
endfunction

function! s:saveAndClose() abort
    call VSCodeCall('workbench.action.files.save')
    call VSCodeNotify('workbench.action.closeActiveEditor')
endfunction

function! s:saveAllAndClose() abort
    call VSCodeCall('workbench.action.files.saveAll')
    call VSCodeNotify('workbench.action.closeAllEditors')
endfunction

" command! -bang -nargs=? Edit call VSCodeCall('workbench.action.quickOpen')
command! -complete=file -bang -nargs=? Edit call <SID>editOrNew(<q-args>, <q-bang>)
command! -bang -nargs=? Ex call <SID>editOrNew(<q-args>, <q-bang>)
command! -bang Enew call <SID>editOrNew('__vscode_new__', <q-bang>)
command! -bang Find call VSCodeNotify('workbench.action.quickOpen')

command! -complete=file -bang Write if <q-bang> == '!' | call VSCodeNotify('workbench.action.files.saveAs') | else | call VSCodeNotify('workbench.action.files.save') | endif
command! -bang Saveas call VSCodeNotify('workbench.action.files.saveAs')

command! -bang Wall call VSCodeNotify('workbench.action.files.saveAll')
command! -bang Quit if <q-bang> == '!' | call VSCodeNotify('workbench.action.revertAndCloseActiveEditor') | else | call VSCodeNotify('workbench.action.closeActiveEditor') | endif

command! -bang Wq call <SID>saveAndClose()

command! -bang Qall call VSCodeNotify('workbench.action.closeAllEditors')

command! -bang Wqall call <SID>saveAllAndClose()
command! -bang Xall call <SID>saveAllAndClose()

AlterCommand e[dit] Edit
AlterCommand ex Ex
AlterCommand ene[w] Enew
AlterCommand fin[d] Find
AlterCommand w[rite] Write
AlterCommand sav[eas] Saveas
AlterCommand wa[ll] Wall
AlterCommand q[uit] Quit
AlterCommand wq Wq
AlterCommand qa[ll] Qall
AlterCommand wqa[ll] Wqall
AlterCommand xa[ll] Xall

nnoremap <silent> <leader>wq :Wq<CR>
nnoremap <silent> <leader>w :W<CR>
nnoremap <silent> <leader>qq :Quit!<CR>


" window
function! s:split(...) abort
    let direction = a:1
    let file = a:2
    call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if file != ''
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

AlterCommand sp[lit] Split
AlterCommand vs[plit] Vsplit
AlterCommand new New
AlterCommand vne[w] Vnew
AlterCommand on[ly] Only

nnoremap <silent> <C-w>s :<C-u>call <SID>split('h')<CR>
xnoremap <silent> <C-w>s :<C-u>call <SID>split('h')<CR>

nnoremap <silent> <C-w>v :<C-u>call <SID>split('v')<CR>
xnoremap <silent> <C-w>v :<C-u>call <SID>split('v')<CR>

nnoremap <silent> <C-w>n :<C-u>call <SID>splitNew('h', '__vscode_new__')<CR>
xnoremap <silent> <C-w>n :<C-u>call <SID>splitNew('h', '__vscode_new__')<CR>

nnoremap <silent> <C-w>q :<C-u>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <silent> <C-w>q :<C-u>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <silent> <C-w>c :<C-u>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <silent> <C-w>c :<C-u>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

nnoremap <silent> <C-w>o :<C-u>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
xnoremap <silent> <C-w>o :<C-u>call VSCodeNotify('workbench.action.joinAllGroups')<CR>

nnoremap <silent> <C-w>j :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <silent> <C-w>j :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <silent> <C-w><C-j> :<C-u>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <silent> <C-w><C-j> :<C-u>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <silent> <C-w>k :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <silent> <C-w>k :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <silent> <C-w><C-i> :<C-u>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <silent> <C-w><C-i> :<C-u>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <silent> <C-w>h :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <silent> <C-w>h :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <silent> <C-w><C-h> :<C-u>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <silent> <C-w><C-h> :<C-u>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <silent> <C-w>l :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <silent> <C-w>l :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nnoremap <silent> <C-w><C-l> :<C-u>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <silent> <C-w><C-l> :<C-u>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
nnoremap <silent> <C-w>w :<C-u>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <silent> <C-w>w :<C-u>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
xnoremap <silent> <C-w><C-w> :<C-u>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
xnoremap <silent> <C-w><C-w> :<C-u>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <silent> <C-w>W :<C-u>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
xnoremap <silent> <C-w>W :<C-u>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
nnoremap <silent> <C-w>p :<C-u>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
xnoremap <silent> <C-w>p :<C-u>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
nnoremap <silent> <C-w>t :<C-u>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
xnoremap <silent> <C-w>t :<C-u>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
nnoremap <silent> <C-w>b :<C-u>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>
xnoremap <silent> <C-w>b :<C-u>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>

nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>

nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

nnoremap <C-w>H :<C-u>echoerr 'Not supported yet'<CR>
xnoremap <C-w>H :<C-u>echoerr 'Not supported yet'<CR>
nnoremap <C-w>L :<C-u>echoerr 'Not supported yet'<CR>
xnoremap <C-w>L :<C-u>echoerr 'Not supported yet'<CR>
nnoremap <C-w>K :<C-u>echoerr 'Not supported yet'<CR>
xnoremap <C-w>K :<C-u>echoerr 'Not supported yet'<CR>
nnoremap <C-w>J :<C-u>echoerr 'Not supported yet'<CR>
xnoremap <C-w>J :<C-u>echoerr 'Not supported yet'<CR>

" multi line insert
function! s:vscodeInsertBefore()
    call VSCodeExtensionNotify('insert-line', 'before')
endfunction

function! s:vscodeInsertAfter()
    call VSCodeExtensionNotify('insert-line', 'after')
endfunction

function! s:vscodeMultipleCursorsVisualMode(append, skipEmpty)
    let m = visualmode()
    if m == "V" || m == "\<C-v>"
        startinsert
        call VSCodeExtensionNotify('visual-edit', a:append, m, line("'<"), line("'>"), a:skipEmpty)
    endif
endfunction

nnoremap <silent> O :<C-u> call<SID>vscodeInsertBefore()<CR>
nnoremap <silent> o :<C-u> call<SID>vscodeInsertAfter()<CR>

" Multiple cursors support for visual line/block modes
xnoremap <silent> ma :<C-u>call <SID>vscodeMultipleCursorsVisualMode(1, 1)<CR>
xnoremap <silent> mi :<C-u>call <SID>vscodeMultipleCursorsVisualMode(0, 1)<CR>
xnoremap <silent> mA :<C-u>call <SID>vscodeMultipleCursorsVisualMode(1, 0)<CR>
xnoremap <silent> mI :<C-u>call <SID>vscodeMultipleCursorsVisualMode(0, 0)<CR>

" VIM jumplist is used now
" nnoremap <silent> <C-o> :<C-u>call VSCodeNotify("workbench.action.navigateBack")<CR>
" nnoremap <silent> <C-i> :<C-u>call VSCodeNotify("workbench.action.navigateForward")<CR>
" nnoremap <silent> <Tab> :<C-u>call VSCodeNotify("workbench.action.navigateForward")<CR>

function s:jump(forward)
    let g:isJumping = 1
    exe a:forward ? "normal! 1\<C-i>" : "normal! \<C-o>"
    let g:isJumping = 0
endfunction

nnoremap <silent> <C-o> :<C-u>call <SID>jump(0)<CR>
nnoremap <silent> <C-i> :<C-u>call <SID>jump(1)<CR>
" nnoremap <silent> <Tab> :<C-u>call <SID>jump(1)<CR>
