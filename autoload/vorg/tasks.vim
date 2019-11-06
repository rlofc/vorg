function! vorg#tasks#toggleCheckbox() range
	let view = winsaveview()
	if a:firstline != a:lastline || s:toggleRadio(a:firstline) == 0
		let lines = getline(a:firstline, a:lastline)
		let linenum = a:firstline
		for line in lines
				if line =~? "\\[x\\]"
					call setline(linenum, substitute(line, "\\[[xX]\\]", "[ ]", ""))
				elseif line =~? "\\[ \\]"
					call setline(linenum, substitute(line, "\\[ \\]", "[x]", ""))
				endif

				let linenum += 1
		endfor
	endif
	call winrestview(view)
endfunction

function! s:clearRadioBlock(linenum)
	let ind_level = indent(a:linenum)
	for direction in [1, -1]
		let curline = a:linenum + direction
		while 1
				let line = getline(curline)
				if indent(curline) == ind_level && line =~? "([x ])"
					call setline(curline, substitute(line, "([xX])", "( )", ""))
				else
					break
				endif
				let curline += direction
		endwhile
	endfor
endfunction

function! s:toggleRadio(linenum)
	let line = getline(a:linenum)
	if line =~? "(x)"
		call setline(a:linenum, substitute(line, "([xX])", "( )", ""))
		return 1
	elseif line =~? "( )"
		call s:clearRadioBlock(a:linenum)
		call setline(a:linenum, substitute(line, "( )", "(x)", ""))
		return 1
	endif

	return 0
endfunction
