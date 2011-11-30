" vorg.vim - Vim ORG mode. Your stuff in plain text.
" Maintainer:   Ithai Levi <http://github.org/L3V3L9/>
" Version:      0.2
" GetLatestVimScripts: 2842 1 :AutoInstall: vorg.vim

" Syntax Definition
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match vorgDeadline        "[<>^]\ \d*[/-]\d*[/-]\d*" contained
syn match vorgTag             "<.*>" contained
syn match vorgLink            "\%(http://\|www\.\)[^ ,;\t]*" contained
syn match vorgTitle           "^\t*[-\*].*" contains=vorgTag,vorgLink
syn match vorgTaskAlt         "\t*\[[o\ ]\].*" contains=vorgTag,vorgDeadline,vorgLink
syn match vorgTask            "\t*[-\*].*\[[o\ ]\].*" contains=vorgTag,vorgDeadline,vorgLink
syn match vorgDone            "\t*[-\*].*\[[X|x]\].*"  
syn match vorgDoneAlt         "\t*\[[X|x]\].*" 
syn match vorgComment         "// .*"
syn match vorgLogdate         "\t*[-\*].*\~\ \d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*.*" contains=vorgTag,vorgLink
syn match vorgPrefixLogdate   "\t*[-\*]\ *\d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*\ \~.*" contains=vorgTag,vorgLink

hi Function gui=bold
hi Constant gui=bold
hi Keyword gui=bold
hi Number gui=underline

hi def link vorgComment       Comment
hi def link vorgDone	        Comment 
hi def link vorgDoneAlt	      Comment
hi def link vorgTitle         Function
hi def link vorgTaskAlt       Keyword
hi def link vorgTask          Keyword
hi def link vorgTag           Comment
hi def link vorgDeadline      String
hi def link vorgLogdate       Constant
hi def link vorgPrefixLogdate Constant
hi! vorgLink gui=underline         
hi! link Folded Comment
" Special, Function Constant Statement
" Custom Folding --------------------
function! SimpleFoldText() 
	return	repeat(' ',indent(v:foldstart)).substitute(getline(v:foldstart),"[ \t]*[-\*]","+","").' '
endfunction 
set foldtext=SimpleFoldText() " Custom fold text function

function! LimitFoldLevel(level)
	return a:level
	"if a:level>3
	"	return 3
	"else
	"	return a:level
	"endif
endfunction

function! VorgFoldExpr(lnum)
    if match(getline(a:lnum),'^[ \t]*$') != -1
	if indent(prevnonblank(a:lnum-1)) > indent(nextnonblank(a:lnum+1))
		if nextnonblank(a:lnum+1) == a:lnum+1
			return  '<'.LimitFoldLevel(indent(prevnonblank(a:lnum-1)) / &sw) 
		endif
	endif
	return '='
    endif
    if indent( nextnonblank(a:lnum+1) ) > indent( a:lnum )
	    if indent(prevnonblank(a:lnum-1)) > indent(a:lnum)
		    return '>'.(LimitFoldLevel(indent(a:lnum) / &sw  +1))
	    else
		    return LimitFoldLevel(indent( a:lnum ) / &sw  +1)
            endif
    endif

    if indent( nextnonblank(a:lnum+1) ) == indent( a:lnum )	    
	    return LimitFoldLevel(indent( a:lnum ) / &sw) 
    endif

    if indent( nextnonblank(a:lnum+1) ) < indent( a:lnum )
	    if nextnonblank(a:lnum+1) > a:lnum+1
		    return  LimitFoldLevel(indent(a:lnum) / &sw) 
	    else
		    return  '<'.LimitFoldLevel(indent(a:lnum) / &sw) 
	    endif
    endif

    return '='
endfunction

set foldmethod=expr
set foldexpr=VorgFoldExpr(v:lnum) 

let b:current_syntax = "vorg"
