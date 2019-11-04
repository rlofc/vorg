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

syn match vorgDeadline        "[<>^]\ \d*[/-]\d*[/-]\d*" contained
syn match vorgTag             "<.*>" contained
syn match vorgLink            "\%(http://\|www\.\)[^ ,;\t]*" contained

syn match vorgLogDate         "[~|]\ \d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*" contained
syn match vorgPrefixLogDate   "\ *\d*[/-]\d*[/-]\d*[ ]@[ ]\d*:\d*\ [~|]" contained

syn match vorgDoneText        ".*" contained
syn match vorgTaskText        ".*" contained contains=vorgTag,vorgDeadline,vorgLink,vorgLogDate,vorgPrefixLogDate
syn match vorgTask            "\[[ ]\]" contained nextgroup=vorgTaskText
syn match vorgTaskDone        "\[[xX]\]" contained nextgroup=vorgDoneText

syn match vorgFreeText        ".*" contains=vorgDeadline,vorgTag,vorgLink,vorgTask,vorgTaskDone,vorgTitle,vorgLogDate,vorgPrefixLogDate
syn match vorgListItem        "\t*[-*].*" contains=vorgDeadline,vorgTag,vorgLink,vorgTask,vorgTaskDone,vorgTitle,vorgLogDate,vorgPrefixLogDate
syn match vorgComment         "// .*"

hi def link vorgComment        Comment
hi def link vorgTag            Comment
hi def link vorgTaskText       String
hi def link vorgDoneText       Comment
hi def link vorgListItem       Function
hi def link vorgTask           Special
hi def link vorgTaskDone       Special
hi def link vorgDeadline       Todo
hi def link vorgLogDate        Constant
hi def link vorgPrefixLogDate  Constant
hi def link vorgLink           Constant

" Fold based on the Vorg specification
function! VorgFoldText()
    let foldlines = getline(v:foldstart, v:foldend)
    let text = repeat(' ', indent(v:foldstart)) . substitute(foldlines[0] ,"[ \t]*[-\*]" ,"+" ,"")
    let total_boxes = 0
    let total_checked = 0
    for line in foldlines
        if match(line, "\\[ \\]") > -1
            let total_boxes += 1
        elseif match(line, "\\[x\\]") > -1
            let total_boxes += 1
            let total_checked += 1
        endif
    endfor
    if total_boxes > 0
        let text .= " [ " . total_checked . " / " . total_boxes . " ]"
    endif
    return text . ' '
endfunction

setlocal foldtext=VorgFoldText() " Custom fold text function

function! LimitFoldLevel(level)
	return a:level
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

setlocal foldmethod=expr
setlocal foldexpr=VorgFoldExpr(v:lnum)

let b:current_syntax = "vorg"
