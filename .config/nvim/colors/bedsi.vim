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

highlight Statement ctermfg=3
highlight Identifier ctermfg=3 cterm=NONE
highlight Comment ctermfg=5
highlight Number ctermfg=4
highlight String ctermfg=2

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
highlight ColorColumn ctermbg=0
highlight Visual ctermbg=0 ctermfg=NONE
highlight TODO ctermbg=8 ctermfg=NONE cterm=bold

" -----------------
" LANGUAGE SPECIFIC
" -----------------

" shellscript
highlight shSetList ctermfg=NONE ctermbg=NONE
highlight shOperator ctermfg=NONE ctermbg=NONE

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
