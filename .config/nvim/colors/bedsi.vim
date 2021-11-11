highlight clear
if exists('syntax_on')
    syntax reset
endif

set background=dark
set notermguicolors
let g:colors_name = 'bedsi'

" ------
" BASICS
" ------

highlight Statement ctermfg=4
highlight Comment ctermfg=6
highlight Number ctermfg=1
highlight String ctermfg=5

" -------
" VARIOUS
" -------

highlight Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
highlight Visual ctermbg=0 ctermfg=NONE
highlight LineNr ctermbg=NONE ctermfg=8
highlight CursorLineNr ctermbg=NONE ctermfg=NONE cterm=bold
highlight TabLineFill ctermbg=NONE ctermfg=0
highlight TabLine ctermbg=7 ctermfg=0 cterm=reverse
highlight TabLineSel ctermbg=8 ctermfg=NONE
highlight StatusLine ctermbg=0 ctermfg=NONE cterm=NONE
highlight StatusLineNC ctermbg=0 ctermfg=0 cterm=NONE
highlight VertSplit ctermbg=0 ctermfg=8 cterm=NONE
highlight ColorColumn ctermbg=0
highlight Visual ctermbg=0 ctermfg=NONE
highlight TODO ctermbg=8 ctermfg=NONE cterm=bold

" -----------------
" LANGUAGE SPECIFIC
" -----------------

highlight shSetList ctermfg=NONE ctermbg=NONE
highlight shSetList ctermfg=NONE ctermbg=NONE
highlight shOperator ctermfg=NONE ctermbg=NONE
highlight shTestOpr ctermfg=NONE ctermbg=NONE
highlight shFunction ctermfg=3 ctermbg=NONE
highlight shDerefSimple ctermfg=5 ctermbg=NONE
highlight shStatement ctermfg=NONE ctermbg=NONE
highlight shVarAssign ctermfg=2 ctermbg=NONE
" highlight shArithRegion ctermfg=3 ctermbg=NONE
highlight bashStatement ctermfg=NONE ctermbg=NONE

highlight vimFuncName ctermfg=NONE ctermbg=NONE
highlight vimHiClear ctermfg=NONE ctermbg=NONE
highlight vimVar ctermfg=NONE ctermbg=NONE

highlight luaFunc ctermfg=NONE ctermbg=NONE

" highlight goType ctermfg=3

" -------
" PLUGINS
" -------

" indent-blankline.nvim
highlight IndentBlanklineChar ctermfg=8

" -------------------
" CLEARING HIGHLIGHTS
" -------------------

highlight Normal ctermfg=NONE ctermbg=NONE
highlight Constant ctermfg=NONE ctermbg=NONE
highlight PreProc ctermfg=NONE ctermbg=NONE
highlight Type ctermfg=NONE ctermbg=NONE
highlight Special ctermfg=NONE ctermbg=NONE
highlight CursorLine ctermbg=NONE cterm=NONE
highlight Special ctermbg=NONE ctermfg=NONE
highlight Operator ctermbg=NONE ctermfg=NONE
highlight Repeat ctermbg=NONE ctermfg=NONE
