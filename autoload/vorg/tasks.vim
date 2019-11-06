function! vorg#tasks#toggleCheckbox() range
	let view = winsaveview()
	if a:firstline != a:lastline || s:toggleRadio(a:firstline) == 0
		let lines = getline(a:firstline, a:lastline)
		let lnum = a:firstline
		for line in lines
				if line =~? "\\[x\\]"
					call setline(lnum, substitute(line, "\\[[xX]\\]", "[ ]", ""))
				elseif line =~? "\\[ \\]"
					call setline(lnum, substitute(line, "\\[ \\]", "[x]", ""))
				endif

				let lnum += 1
		endfor
	endif
	call winrestview(view)
endfunction

function! s:radioInitialIndent(lnum)
	return indent(a:lnum)
endfunction

function! s:radioCondition(ind_level, lnum)
	return indent(a:lnum) == a:ind_level && getline(a:lnum) =~? "([x ])"
endfunction

function! s:radioParse(ind_level, lnum)
	return setline(a:lnum, substitute(getline(a:lnum), "([xX])", "( )", ""))
endfunction

function! s:toggleRadio(lnum)
	let line = getline(a:lnum)
	if line =~? "(x)"
		call setline(a:lnum, substitute(line, "([xX])", "( )", ""))
		return 1
	elseif line =~? "( )"
		call vorg#util#parseLinesAround(a:lnum, function("s:radioInitialIndent"), function("s:radioCondition"), function("s:radioParse"))
		call setline(a:lnum, substitute(line, "( )", "(x)", ""))
		return 1
	endif

	return 0
endfunction
