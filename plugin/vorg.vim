" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.3
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

if exists('loaded_vorg')
	finish
endif

" Offical Vorg interface commands
command -nargs=? VorgGatherAll :call vorg#gatherAll(input("Search files for: "))
command -nargs=? VorgGather :call vorg#gather(input("Search for: "))
command -nargs=? VorgTableExport :call vorg#table#export(input("Export format: "))

augroup vorg_tables
	autocmd InsertLeave *.vorg call vorg#table#align()
augroup END

let loaded_vorg = 1
