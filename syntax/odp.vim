if exists("b:current_syntax")
  finish
end

syn match odpComment ' *#.*$'
syn match odpBlock '\[[^\.].*\]'
syn match odpSubblock '\[\.[^\.]*\]'
syn match odpSubSubblock '\[\.\.[^\.]*\]'
syn match odpSSSblock '\[\.\.\.[^\.]*\]'
syn match odpEntityKey '^[^\ *#][^:]*:'
syn match ipAndPort '\(\d\{1,3}\.\)\{3}\d\{1,3}:\d\{1,5}'
syn match url 'http[s]\=://.*\( \|$\)'

hi hiUrl  term=underline  cterm=underline  ctermfg=lightblue guifg=Yellow

hi link odpComment Comment
hi link odpBlock Identifier
hi link odpSubblock Constant
hi link odpSubSubblock Keyword 
hi link odpSSSblock Special 
hi link odpEntityKey Type
hi link ipAndPort Special
hi link url hiUrl

let b:current_syntax = "odpconf"
