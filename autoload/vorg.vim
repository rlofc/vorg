function! vorg#dateFollowing(nDays)
	let dir  = a:nDays < 0 ? -1 : 1
	let day  = abs(a:nDays) % 7
	let sday = 60 * 60 * 24 * dir
	let time = localtime() + sday
	while strftime('%w', time) != day
		let time += sday
	endwhile
	return strftime('%Y-%m-%d', time)
endfunction

function! s:tmpQuickfix()
	copen
	nnoremap <buffer> o <CR>
	nnoremap <buffer> q :q<CR>
endfunction

function! vorg#gather(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j " . substitute(expand('%'), " ", "\\\\ ", "g")
		call s:tmpQuickfix()
	endif
endfunction

function! vorg#gatherAll(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j **/*.vorg"
		call s:tmpQuickfix()
	endif
endfunction
