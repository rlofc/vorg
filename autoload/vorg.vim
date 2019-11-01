function! vorg#ToggleCheckbox()
    let line = getline(".")
    if match(line, "\[x\]") > -1
        s/\[x\]/[ ]
    else
        s/\[ \]/[x]
    endif
endfunction

