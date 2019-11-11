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

function! s:export_html(data)
	let lines = ["<table>"]
	let ind = &g:et ? repeat(" ", &g:sw) : "\t"
	for row in a:data
		call add(lines, ind . "<tr>")
		for column in row
			call add(lines, ind . ind . "<td>" . column . "</td>")
		endfor
		call add(lines, ind . "</tr>")
	endfor
	call add(lines, "</table>")
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

