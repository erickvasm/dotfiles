highlight clear

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction

let s:Color0 = '#A89984'
let s:Color1 = '#EBDBB2'
let s:Color2 = '#FB5245'
let s:Color3 = '#FAC149'
let s:Color4 = '#D3869B'
let s:Color5 = '#B8BB26'
let s:Color6 = '#1e1e1e'
let s:Color7 = '#ebdbb2'
let s:Color8 = '#262626'
let s:Color9 = '#373d29'
let s:Color10 = '#4b1818'
let s:Color11 = '#442b43'
let s:Color12 = '#555049'
let s:Color13 = '#8e8e8e'
let s:Color14 = '#ffffff'

call s:highlight('Comment', '', s:Color0, 'italic')
call s:highlight('Identifier', '', s:Color1, '')
call s:highlight('Error', '', s:Color2, '')
call s:highlight('Keyword', '', s:Color2, 'italic')
call s:highlight('Operator', '', s:Color1, '')
call s:highlight('Function', '', s:Color3, '')
call s:highlight('Number', '', s:Color4, '')
call s:highlight('TSCharacter', '', s:Color4, '')
call s:highlight('String', '', s:Color5, '')
call s:highlight('StatusLine', s:Color7, s:Color6, '')
call s:highlight('WildMenu', s:Color6, s:Color7, '')
call s:highlight('Pmenu', s:Color6, s:Color7, '')
call s:highlight('PmenuSel', s:Color7, s:Color8, '')
call s:highlight('PmenuThumb', s:Color6, s:Color7, '')
call s:highlight('DiffAdd', s:Color9, '', '')
call s:highlight('DiffDelete', s:Color10, '', '')
call s:highlight('Normal', s:Color6, s:Color7, '')
call s:highlight('Visual', s:Color11, '', '')
call s:highlight('CursorLine', s:Color11, '', '')
call s:highlight('ColorColumn', s:Color11, '', '')
call s:highlight('SignColumn', s:Color6, '', '')
call s:highlight('LineNr', '', s:Color12, '')
call s:highlight('TabLine', s:Color6, s:Color13, '')
call s:highlight('TabLineSel', s:Color14, s:Color8, '')
call s:highlight('TabLineFill', s:Color6, s:Color13, '')
call s:highlight('TSPunctDelimiter', '', s:Color7, '')
call s:highlight('TSPunctBracket', '', s:Color3, '')

" Añadir líneas específicas para Keywords y Function
call s:highlight('Keyword', '', s:Color2, '')
call s:highlight('Function', '', s:Color3, '')

highlight! link TSField Constant
highlight! link Macro Function
highlight! link TSNamespace TSType
highlight! link TSParameterReference TSParameter
highlight! link TSTagDelimiter Type
highlight! link TSFuncMacro Macro
highlight! link TSComment Comment
highlight! link CursorLineNr Identifier
highlight! link TSConstBuiltin TSVariableBuiltin
highlight! link TSFunction Function
highlight! link NonText Comment
highlight! link TSKeyword Keyword
highlight! link TSTag MyTag
highlight! link TSConditional Conditional
highlight! link TSType Type
highlight! link TSString String
highlight! link Repeat Conditional
highlight! link TSPunctBracket MyTag
highlight! link TSParameter Constant
highlight! link TSProperty TSField
highlight! link TSNumber Number
highlight! link TSConstant Constant
highlight! link TSPunctSpecial TSPunctDelimiter
highlight! link Operator Keyword
highlight! link TelescopeNormal Normal
highlight! link TSLabel Type
highlight! link TSRepeat Repeat
highlight! link Conditional Operator
highlight! link Folded Comment
highlight! link TSOperator Operator
highlight! link Whitespace Comment
highlight! link TSFloat Number
