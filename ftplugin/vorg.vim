" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.2
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

"Settings
setlocal smartindent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal noexpandtab

nmap <buffer> <TAB> za
nmap <buffer> <S-TAB> zA
nmap <buffer> ,c ma0t]rx`a
nmap <buffer> ,u ma0t]r `a
nmap <buffer> <F7> mz:m+<CR>==`z
nmap <buffer> <F6> mz:m-2<CR>==`z

ab <buffer> -- <TAB>-
ab <buffer> -= - [ ]

" Quickly insert dates in insert mode
ab <buffer> dd <C-R>=strftime("%Y-%m-%d")<CR>
ab <buffer> dt <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR>
ab <buffer> -0 - <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR> \|

" Shift lines up and down
nnoremap <buffer> <C-j> mz:m+<CR>`z
nnoremap <buffer> <C-k> mz:m-2<CR>`z
inoremap <buffer> <C-j> <Esc>:m+<CR>gi
inoremap <buffer> <C-k> <Esc>:m-2<CR>gi
vnoremap <buffer> <C-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <buffer> <C-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

nnoremap <buffer> <C-o> :/[-\*]\ *\[\ \].*@
nnoremap <buffer> <C-t> :/-.*(.*.*)<LEFT><LEFT><LEFT>

ab <buffer> dn1 <C-R>=DateLastDay(1)<CR>
ab <buffer> dn2 <C-R>=DateLastDay(2)<CR>
ab <buffer> dn3 <C-R>=DateLastDay(3)<CR>
ab <buffer> dn4 <C-R>=DateLastDay(4)<CR>
ab <buffer> dn5 <C-R>=DateLastDay(5)<CR>
ab <buffer> dn6 <C-R>=DateLastDay(6)<CR>
ab <buffer> dn7 <C-R>=DateLastDay(7)<CR>
"nnoremap <silent> <Leader>n1 =DateLastDay(1)


map <buffer> ,w :VorgFollowLink()<CR>

if exists("*SpeedDatingFormat")
	" Speeddating integration - config date format
	SpeedDatingFormat %Y-%m-%d
endif


