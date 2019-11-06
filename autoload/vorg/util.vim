function! vorg#util#parseLinesAround(lnum, fun_start, fun_condition, fun_parse)
	let start_data = a:fun_start(a:lnum)
	let data = []
	for direction in [1, -1]
		let curline = a:lnum + direction
		while a:fun_condition(start_data, curline)
				call add(data, [curline, a:fun_parse(start_data, curline)])
				let curline += direction
		endwhile
	endfor
	return data
endfunction
