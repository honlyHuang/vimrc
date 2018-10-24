" Vim color scheme
"
" Name:         colinvivy.vim
" Maintainer:   colinvivy 
" Last Change:  2011-06-20
" License:      public domain

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "colinvivy"

if has("gui_running")
  hi link htmlTag                     xmlTag
  hi link htmlTagName                 xmlTag
  hi link htmlEndTag                  xmlTag
  hi link xmlTag                      xmlTag
  hi link xmlTagName                  xmlTag
  hi link xmlEndTag                   xmlTag
  hi link Function                    Statement
  hi link Number                      String

  " 功能界面
  highlight Normal					  guifg=#CCCCCC   guibg=#151c22
  highlight Cursor                    guifg=#FFFFFF   guibg=#014ccc
  highlight CursorLine                guibg=#333333
  highlight LineNr                    guifg=#AAAAAA   guibg=#1A2433
  highlight Search                    guifg=#000000   guibg=#FFFF00
  highlight Visual                    guibg=#000000

  highlight DiffAdd                   guifg=#E6E1DC   guibg=#144212
  highlight DiffDelete                guifg=#E6E1DC   guibg=#660000
 
  " common language
  highlight xmlTag                    guifg=#AAAAAA
  " 暗绿色
  highlight Comment                   guifg=#00CC00   
  " 粉红色
  highlight String                    guifg=#E77EE7
  " 亮兰色
  highlight jsMethod                  guifg=#00ffff
  " 浅蓝色
  highlight Statement                 guifg=#8888EE   gui=NONE
  highlight Label                     guifg=#8888EE   gui=NONE
  highlight Special                   guifg=#9999EE   gui=NONE

  highlight Error                     guifg=#FFFFFF   guibg=#990000
  highlight Type                      guifg=#97D8FF   gui=NONE

  " ruby language
  highlight rubyBlockParameter        guifg=#FFFFFF
  highlight rubyClass                 guifg=#FFFFFF
  highlight rubyConstant              guifg=#DA4939
  highlight rubyInstanceVariable      guifg=#D0D0FF
  highlight rubyInterpolation         guifg=#519F50
  highlight rubyLocalVariableOrMethod guifg=#D0D0FF
  highlight rubyPredefinedConstant    guifg=#DA4939
  highlight rubyPseudoVariable        guifg=#FFC66D
  highlight rubyStringDelimiter       guifg=#A5C261
  
  highlight Define                    guifg=#CC7833
  highlight Include                   guifg=#CC7833   gui=NONE
  highlight Keyword                   guifg=#CC7833

  highlight Folded                    guifg=#FFFFFF    guibg=#000000
  highlight Constant                  guifg=#6D9CBE
  highlight Identifier                guifg=#6D9CBE   gui=NONE
  highlight PreProc                   guifg=#00ffff
  highlight Title                     guifg=#FFFFFF

endif


