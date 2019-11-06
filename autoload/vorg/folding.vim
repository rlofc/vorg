function! vorg#folding#foldText()
	let foldlines = getline(v:foldstart, v:foldend)
	let header = substitute(foldlines[0], "^\\s*-", "+", "")
	let text = repeat(' ', indent(v:foldstart)) . header

	let total_boxes = 0
	let total_checked = 0
	for line in foldlines
		if match(line, "\\[ \\]") > -1
			let total_boxes += 1
		elseif match(line, "\\[x\\]") > -1
			let total_boxes += 1
			let total_checked += 1
		endif
	endfor
	if total_boxes > 0
		let text .= " [ " . total_checked . " / " . total_boxes . " ]"
	endif
	return text . ' '
endfunction

function! s:getFoldLevel(lnum)
	let cur_ind = indent(a:lnum)
	let lnum = a:lnum - 1
	while lnum > 0 && cur_ind > 0
		let ind = indent(lnum)
		if ind < cur_ind
			let line = getline(lnum)
			if line =~ "^\\s*-"
				return s:getFoldLevel(lnum) + 1
			elseif line !~ "^\\s*$"
				let cur_ind = ind
			endif
		endif
		let lnum -= 1
	endwhile
	return 0
endfunction

function! vorg#folding#foldExpr(lnum)
	" an empty line - same level
	let line = getline(a:lnum)
	if line =~ "^\\s*$"
		return '='
	endif

	let current_fold_level = s:getFoldLevel(a:lnum)
	let this_line_indent = indent(a:lnum)
	let next_line_indent = indent(nextnonblank(a:lnum + 1))

	if this_line_indent < next_line_indent && line =~ "^\\s*-"
		let current_fold_level += 1
		if s:getFoldLevel(prevnonblank(a:lnum - 1)) >= current_fold_level
			return ">" . current_fold_level
		endif
	endif
	return current_fold_level
endfunction
