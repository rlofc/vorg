" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.3
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

if exists('loaded_vorg')
	finish
endif
let loaded_vorg = 1

function! s:Gather(pattern)
  if !empty(a:pattern)
    let results = []
    execute "vimgrep " . a:pattern . " " . expand('%')
    :copen
  endif
endfunction

function! s:GatherAllVorgs(pattern)
  if !empty(a:pattern)
    let results = []
    execute "vimgrep " . a:pattern . " **/*.vorg"
    :copen
  endif
endfunction

" Offical Vorg interface commands
if !exists(":VorgGather")
    command -nargs=? VorgGather :call <SID>Gather(input("Search for: "))
endif
if !exists(":VorgGatherAll")
    command -nargs=? VorgGatherAll :call <SID>GatherAllVorgs(input("Search for: "))
endif

let b:current_syntax = "vorg"
