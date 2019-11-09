function! s:export_json(data)
	return json_encode(a:data)
endfunction

function! s:export_csv(data)
	let lines = []
	for row in a:data
		let row = map(row, {
			\i, val -> substitute(val, '"', '\\"', "g")
		\})
		call add(lines, '"' . join(row, '","') . '"')
	endfor
	return lines
endfunction

function! vorg#exporters#getExporter(format)
	let fname = "s:export_" . tolower(a:format)
	if !exists("*" . fname)
		throw "no exporter for format " . a:format
	endif
	let Func = function(fname)
	return Func
endfunction

