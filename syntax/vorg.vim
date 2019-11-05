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
syn match vorgTaskDone        "\[[xX]\]" contained
syn match vorgDoneText        ".*\[[xX]\].*" contained contains=vorgTaskDone

syn match vorgListItem        "^\s*-" contained

syn match vorgText            ".*" contains=ALL nextgroup=vorgComment

hi def link vorgComment        Comment
hi def link vorgTag            Comment
hi def link vorgDoneText       Comment
hi def link vorgListItem       Function
hi def link vorgTask           Special
hi def link vorgTaskDone       Special
hi def link vorgDeadline       Todo
hi def link vorgLogDate        String
hi def link vorgPrefixLogDate  String
hi def link vorgLink           Constant
hi def link vorgIpv4           Constant
hi def link vorgHex            Constant

" Fold based on the Vorg specification
function! VorgFoldText()
    let foldlines = getline(v:foldstart, v:foldend)
    let header = substitute(foldlines[0], "\s*-", "+", "")
    let indent = indent(v:foldstart)
    let text = repeat(' ', indent - indent / &sw) . header

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

function! VorgFoldExpr(lnum)
    " an empty line - same level
    if match(getline(a:lnum), "^\s*$") > -1
        return '='
    endif

    let current_fold_level = foldlevel(a:lnum - 1)
    let this_line_indent = indent(a:lnum)
    let next_line_indent = indent(nextnonblank(a:lnum + 1))
    let prev_line_indent = indent(prevnonblank(a:lnum - 1))
    " get the current fold level
    if current_fold_level == -1
        if prev_line_indent <= this_line_indent
            let current_fold_level = this_line_indent
        else
            let current_fold_level = prev_line_indent
        endif
        let current_fold_level = current_fold_level / &sw
    endif

    let new_fold_level = this_line_indent / &sw
    if next_line_indent > this_line_indent
        " next line is a fold under the current one
        let new_fold_level += 1
        if new_fold_level <= current_fold_level
            " end fold if another one starts with the same level
            return ">" . new_fold_level
        endif
        let current_fold_level = new_fold_level
    elseif new_fold_level <= current_fold_level
        " ignore unexpected double indents
        let current_fold_level = new_fold_level
    endif

    return current_fold_level
endfunction

setlocal foldmethod=expr
setlocal foldexpr=VorgFoldExpr(v:lnum)
setlocal foldtext=VorgFoldText()

let b:current_syntax = "vorg"
