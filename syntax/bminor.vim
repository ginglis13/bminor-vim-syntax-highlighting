" bminor syntax file, for syntax highlighting
"
" Bminor reference:
" https://www3.nd.edu/~dthain/courses/cse40243/fall2019/bminor.html
"
" for use in Compilers course. although the course ended,
" so this really doesn't help at this point. just for fun
"
" more or less just uses rules already defined in the
" scanning stage of the compiler
"
" ginglis

if exists("b:current_syntax")
	finish
endif


" === Keywords ===

syn keyword bminorType array auto boolean char integer string void
syn keyword bminorFunction function
syn keyword bminorAction print return
syn keyword bminorConditional else if
syn keyword bminorFor for
syn keyword bminorBoolean true false


" === Matches ===

syn match bminorInteger "\v[0-9]+"
syn match bminorString  '\v\"([^\"\n\\]|\\\n|\\.){0,255}\"'
syn match bminorChar "\v\'([^\\\']|\\.|�)\'"
syn match bminorIdent "[a-zA-Z_][a-zA-Z0-9_]*"

" Operators  TODO * and / get mixed up w comments
syntax match bminorOperator "\v\*"
syntax match bminorOperator "/"
syntax match bminorOperator "\v\+"
syntax match bminorOperator "\v-"
syntax match bminorOperator "\v\%"
syntax match bminorOperator "\v\>"
syntax match bminorOperator "\v\<"
syntax match bminorOperator "\v\="
syntax match bminorOperator "\v\!"
syntax match bminorOperator "\v\&\&"
syntax match bminorOperator "\v\|\|"


" === Regions ===

" Statement
" just doing blocks for statements
syn region bminorStatement start="{" end="}" fold transparent contains=bminorNumber,bminorStatement,bminorOperator,bminorInteger,bminorComment,bminorAction,bminorBoolean,bminorType,bminorChar,bminorString,bminorConditional,bminorFor,bminorIdent


" C++ style comment
syn region bminorComment start="\/\*" end="\*\/"

" C style comment
syn region bminorComment start="\/\/" end="$"


" Put it all together
let b:current_syntax = 'bminor'

hi def link bminorComment Comment
hi def link bminorType Type
hi def link bminorInteger Number
hi def link bminorString String
hi def link bminorChar Character
hi def link bminorBoolean Boolean
hi def link bminorFunction Function
hi def link bminorOperator Operator
hi def link bminorFor Repeat
hi def link bminorConditional Conditional
hi def link bminorAction Keyword
hi def link bminorStatement Statement
" Make this bminorIdent Identifer if you want your identifiers highlighted
hi def link bminorIdent None

