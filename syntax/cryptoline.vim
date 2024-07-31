if exists("b:current_syntax")
  finish
endif

syn keyword cryptolineStatement assert assume cut ghost proc
syn match cryptolineComment "#.*$"
syn region cryptolineBlockComment start="(\*" end="\*)"
syn match cryptolineNumber '\<\d\+\>'

let b:current_syntax = "cryptoline"
hi def link cryptolineComment Comment
hi def link cryptolineBlockComment Comment
hi def link cryptolineStatement Statement
hi def link cryptolineNumber Number
