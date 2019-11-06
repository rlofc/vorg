" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.3
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

" Syntax Definition
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn match vorgDeadline        "!\d*[/-]\d*[/-]\d*" contained
syn match vorgTag             "#\w\+" contained
syn match vorgComment         "// .*" contained

syn match vorgLink            "\%(https\?://\|www\.\)[^ ,;\t]*" contained
syn match vorgIpv4            "\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\(:\d\{1,5\}\)\?" contained
syn match vorgHex             "0x[0-9a-fA-F]\+" contained

syn match vorgLogDate         "[~|]\ \d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*" contained
syn match vorgPrefixLogDate   "\ *\d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*\ [~|]" contained

syn match vorgTask            "\[[ ]\]" contained
syn match vorgRadio           "([ xX])" contained
syn match vorgTaskDone        "\[[xX]\]" contained
syn match vorgDoneText        ".*\[[xX]\].*" contained contains=vorgTaskDone

syn match vorgListItem        "^\s*-" contained

syn match vorgText            ".*" contains=ALL nextgroup=vorgComment

hi def link vorgComment        Comment
hi def link vorgTag            Comment
hi def link vorgDoneText       Comment
hi def link vorgListItem       Function
hi def link vorgTask           Special
hi def link vorgRadio          Special
hi def link vorgTaskDone       Special
hi def link vorgDeadline       Todo
hi def link vorgLogDate        String
hi def link vorgPrefixLogDate  String
hi def link vorgLink           Constant
hi def link vorgIpv4           Constant
hi def link vorgHex            Constant

setlocal foldmethod=expr
setlocal foldexpr=vorg#folding#foldExpr(v:lnum)
setlocal foldtext=vorg#folding#foldText()

let b:current_syntax = "vorg"
