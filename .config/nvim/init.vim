" GENERAL
    " --- viminfo file path
    set viminfo+=n~/.config/nvim/viminfo
    " --- mouse interaction
    set mouse=a
    " --- clipboard
    set clipboard+=unnamedplus
    " --- line numbers
    set number
    set relativenumber
    " --- disabling highlighted search
    set nohlsearch
    " --- traverse lines with arrow keys
    set whichwrap=b,s,<,>,[,]
    " --- tabs and indents
    set expandtab
    set shiftwidth=4
    set autoindent

" SHORTCUTS
    " --- replace all occurrences
    nnoremap S :%s//g<left><left>

" COLORS
    filetype plugin on 
    syntax on
    syntax reset
    hi clear
    " --- default theme tweaks:
    hi Comment ctermbg=NONE ctermfg=8
    hi StatusLine ctermbg=7 ctermfg=0 cterm=reverse
    hi StatusLineNC ctermbg=8 ctermfg=0 cterm=reverse
    hi LineNr ctermbg=NONE ctermfg=8
    hi CursorLineNr ctermbg=NONE ctermfg=8
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLine ctermbg=7 ctermfg=0 cterm=reverse
    hi TabLineSel ctermbg=8 ctermfg=NONE

" STATUSLINE
    set statusline=
    " --- buffer number
    set statusline+=%#TabLineSel#
    set statusline+=\ %n\ 
    set statusline+=%*
    " --- line numbers
    set statusline+=\ [%l,%c]
    " --- percentage
    set statusline+=\ %p%%
    " --- right align
    set statusline+=%=
    " --- type
    set statusline+=%y
    " --- encoding
    set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
    " --- format
    set statusline+=\(%{&fileformat}\)
    " --- file name
    set statusline+=\ %#TabLineSel#
    set statusline+=\ %f
    set statusline+=%{&modified?'*':''}\ 