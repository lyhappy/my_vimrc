if exists("b:current_syntax")
  finish
end

syn match odpComment ' *#.*$'
syn match odpBlock '\[[^\.].*\]'
syn match odpSubblock '\[\..*\]'
syn match odpEntityKey '^.[^:]*:'

hi link odpComment Comment
hi link odpBlock Identifier
hi link odpSubblock Constant
hi link odpEntityKey Type

let b:current_syntax = "odpconf"
