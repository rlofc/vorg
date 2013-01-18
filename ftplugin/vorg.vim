" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.3
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

" Indentation settings based on the vorg specification
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal noexpandtab

" use TAB in normal mode to fold and unfold patern items
nmap <buffer> <TAB> za
nmap <buffer> <S-TAB> zA

" insert mode shortcuts to add items and tasks
ab <buffer> -- <TAB>-
ab <buffer> -= - [ ]

" normal mode shortcuts to check and uncheck tasks
nmap <buffer> == ma0t]rx`a
nmap <buffer> -- ma0t]r `a

" shortcut for adding tags at the end of an item
imap ` <right><right><space><><left>

" Shift lines up and down
nnoremap <buffer> <C-j> mz:m+<CR>`z
nnoremap <buffer> <C-k> mz:m-2<CR>`z
inoremap <buffer> <C-j> <Esc>:m+<CR>gi
inoremap <buffer> <C-k> <Esc>:m-2<CR>gi
vnoremap <buffer> <C-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <buffer> <C-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" shortcut to find tags
nnoremap <buffer> <C-t> :/-.*\<.*.*\><LEFT><LEFT><LEFT>
nnoremap <buffer> <C-o> :/[-\*]\ *\[\ \].*@

" shortcuts for date entry 
ab <buffer> dd <C-R>=strftime("%Y-%m-%d")<CR>
ab <buffer> dt <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR>
ab <buffer> -0 - <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR> \|

function! s:DateFollowing(nDays)
    let day  = abs(a:day) % 7
    let dir  = a:day < 0 ? -1 : 1
    let sday = 60 * 60 * 24 * dir
    let time = localtime() + sday
    while strftime('%w', time) != nDays
        let time += sday
    endwhile
    return strftime('%Y-%m-%d', time)
endfunction

ab <buffer> dn1 <C-R>=DateFollowing(1)<CR>
ab <buffer> dn2 <C-R>=DateFollowing(2)<CR>
ab <buffer> dn3 <C-R>=DateFollowing(3)<CR>
ab <buffer> dn4 <C-R>=DateFollowing(4)<CR>
ab <buffer> dn5 <C-R>=DateFollowing(5)<CR>
ab <buffer> dn6 <C-R>=DateFollowing(6)<CR>
ab <buffer> dn7 <C-R>=DateFollowing(7)<CR>
