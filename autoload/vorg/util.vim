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

function! vorg#util#export(data, format)
	let Exporter = vorg#exporters#getExporter(a:format)
	let exported = Exporter(a:data)

	enew
	call append(0, exported)
endfunction

function! vorg#util#trim(string)
	return substitute(a:string, '^\s\+\|\s\+$', "", "g")
endfunction
