" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

" Indentation settings based on the vorg specification
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

" insert mode shortcuts
ab <buffer> -[ - [ ]
ab <buffer> [[ [ ]
ab <buffer> -( - ( )
ab <buffer> (( ( )

" normal mode shortcuts
nnoremap <buffer> <silent> cx :call vorg#tasks#toggleCheckbox()<CR>
vnoremap <buffer> <silent> cx :call vorg#tasks#toggleCheckbox()<CR>

nnoremap <buffer> - za
nnoremap <buffer> g- zA
nnoremap <buffer> <silent> ? :call vorg#agenda#show()<CR>

" table key maps
nmap <buffer> <silent> = :call vorg#table#align()<CR>
nmap <buffer> dic T\|dt\|=
nmap <buffer> cic T\|ct\|
nmap <buffer> yic T\|yt\|
nmap <buffer> dac T\|df\|=
nmap <buffer> cac T\|cf\|
nmap <buffer> yac T\|yf\|
vmap <buffer> ic T\|vvt\|
vmap <buffer> ac T\|vvf\|

nmap <buffer> <silent> <Tab> :call vorg#table#jumpCell(1)<CR>
nmap <buffer> <silent> <S-Tab> :call vorg#table#jumpCell(-1)<CR>

" shortcuts for date entry
ab <buffer> dd <C-R>=strftime("%Y-%m-%d")<CR>
ab <buffer> dt <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR>

" add next weekday date shortcuts
ab <buffer> dn1 <C-R>=vorg#dates#nextWeekday(1)<CR>
ab <buffer> dn2 <C-R>=vorg#dates#nextWeekday(2)<CR>
ab <buffer> dn3 <C-R>=vorg#dates#nextWeekday(3)<CR>
ab <buffer> dn4 <C-R>=vorg#dates#nextWeekday(4)<CR>
ab <buffer> dn5 <C-R>=vorg#dates#nextWeekday(5)<CR>
ab <buffer> dn6 <C-R>=vorg#dates#nextWeekday(6)<CR>
ab <buffer> dn7 <C-R>=vorg#dates#nextWeekday(7)<CR>

" add previous weekday date shortcuts
ab <buffer> dp1 <C-R>=vorg#dates#nextWeekday(-1)<CR>
ab <buffer> dp2 <C-R>=vorg#dates#nextWeekday(-2)<CR>
ab <buffer> dp3 <C-R>=vorg#dates#nextWeekday(-3)<CR>
ab <buffer> dp4 <C-R>=vorg#dates#nextWeekday(-4)<CR>
ab <buffer> dp5 <C-R>=vorg#dates#nextWeekday(-5)<CR>
ab <buffer> dp6 <C-R>=vorg#dates#nextWeekday(-6)<CR>
ab <buffer> dp7 <C-R>=vorg#dates#nextWeekday(-7)<CR>
