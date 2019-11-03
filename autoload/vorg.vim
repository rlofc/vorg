function! vorg#ToggleCheckbox() range
    let view = winsaveview()
    let lines = getline(a:firstline, a:lastline)
    let linenum = a:firstline
    for line in lines
        if match(line, "\\[x\\]") > -1
            call setline(linenum, substitute(line, "\\[x\\]", "[ ]", ""))
        elseif match(line, "\\[ \\]") > -1
            call setline(linenum, substitute(line, "\\[ \\]", "[x]", ""))
        endif

        let linenum += 1
    endfor
    call winrestview(view)
endfunction

function! vorg#DateFollowing(nDays)
    let dir  = a:nDays < 0 ? -1 : 1
    let day  = abs(a:nDays) % 7
    let sday = 60 * 60 * 24 * dir
    let time = localtime() + sday
    while strftime('%w', time) != day
        let time += sday
    endwhile
    return strftime('%Y-%m-%d', time)
endfunction
