" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.2
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

if exists('loaded_vorg')
	finish
endif
let loaded_vorg = 1

function! s:Browser ()
	let line = getline (".")
	let line = matchstr (line, "http://\.[^ ,;\t]*")
	exec "silent !surf ".line." > /dev/null &"
endfunction

function! s:Focus()
  let save_cursor = getpos(".")
  let results = []
  execute "g/<\ " . strftime('%Y-%m-%d') . "/call add(results, getline('.')) | delete"
  if !empty(results)
    call setpos('.', save_cursor)
    call append('.',results)
  endif
endfunction
nnoremap <silent> <Leader>z :call Focus() <CR>

" Based on tip 1557 by Niels AdB
" Gather search hits, and display in a new scratch buffer.
function! s:Gather(pattern)
  if !empty(a:pattern)
    let save_cursor = getpos(".")
    let orig_ft = &ft
    " append search hits to results list
    let results = []
    execute "g/" . a:pattern . "/call add(results, getline('.'))"
    call setpos('.', save_cursor)
    if !empty(results)
      " put list in new scratch buffer
      new
      setlocal buftype=nofile bufhidden=hide noswapfile nofen
      execute "setlocal filetype=".orig_ft
      call append(1, results)
      1d  " delete initial blank line
    endif
  endif
endfunction

" Delete the current buffer if it is a scratch buffer (any changes are lost).
function! s:CloseScratch()
  if &buftype == "nofile" && &bufhidden == "hide" && !&swapfile
    " this is a scratch buffer
    bdelete
    return 1
  endif
  return 0
endfunction

function! s:DateOfComingDay(day)
    let day  = abs(a:day) % 7
    let dir  = a:day < 0 ? -1 : 1
    let sday = 60 * 60 * 24 * dir
    let time = localtime() + sday
    while strftime('%w', time) != day
        let time += sday
    endwhile
    return strftime('%Y-%m-%d', time)
endfunction

if !exists(":VorgFocus")
    command -nargs=? VorgFocus :call <SID>Focus()
endif
if !exists(":VorgGather")
    command -nargs=? VorgGather :call <SID>Gather(input("Search for: "))
endif
if !exists(":VorgCloseScratch")
    command -nargs=? VorgCloseScratch :call <SID>CloseScratch()
endif
if !exists(":VorgComingDay")
    command -nargs=? VorgComingDay :echo <SID>DateOfComingDay(<q-args>)
endif
if !exists(":VorgFollowLink")
    command -nargs=? VorgFollowLink :call <SID>Browser()
endif

"nnoremap <silent> <Leader>f :call Gather(input("Search for: "))<CR>
"nnoremap <silent> <Leader>q :call CloseScratch()<CR>

let b:current_syntax = "vorg"

