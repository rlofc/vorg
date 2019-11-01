function! vorg#ToggleCheckbox()
    let line = getline(".")
    if match(line, "\[x\]") > -1
        s/\[x\]/[ ]
    else
        s/\[ \]/[x]
    endif
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
