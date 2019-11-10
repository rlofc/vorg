function! s:tmpQuickfix()
	copen
	nnoremap <buffer> o <CR>
	nnoremap <buffer> q :q<CR>
endfunction

function! vorg#gather(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j " . substitute(expand('%'), " ", '\\ ', "g")
		call s:tmpQuickfix()
	endif
endfunction

function! vorg#gatherAll(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j **/*.vorg"
		call s:tmpQuickfix()
	endif
endfunction
