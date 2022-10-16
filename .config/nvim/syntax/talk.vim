" Vim syntax file
" Language: Talk

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "talk"

syntax keyword   TalkTag   	Title Conference Section
syntax keyword   MockTag   	Mock
syntax keyword   ResourceTag   	Resource

" Comments
syn match	TagComment		"^\s*\zs#.*$"
syn match	TagComment		"\s\zs#.*$"
syn match	TagComment	contained	"#.*$"

hi def link TalkTag           Function
hi def link MockTag           Keyword
hi def link ResourceTag       Special
hi def link TagComment        Comment
