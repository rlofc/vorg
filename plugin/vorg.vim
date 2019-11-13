" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

if exists('g:loaded_vorg')
	finish
endif

" Offical Vorg interface commands
command -nargs=? VorgGatherAll :call vorg#gatherAll(input("Search files for: "))
command -nargs=? VorgGather :call vorg#gather(input("Search for: "))
command -nargs=? VorgTableExport :call vorg#table#export(input("Export format: "))

augroup vorg_tables
	autocmd!
	autocmd InsertLeave *.vorg call vorg#table#align()
augroup END

let g:loaded_vorg = 1
