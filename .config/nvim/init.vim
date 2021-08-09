" Line numbers
    set number
    set relativenumber

" Directory for viminfo file
    set viminfo+=n~/.config/nvim/viminfo

" Traverse line breaks with arrow keys
    set whichwrap=b,s,<,>,[,]

" Syntax highlighting
    filetype plugin on 
    syntax on
    colorscheme ansi

" Mouse interaction
    set mouse=a

" Using system clipboard
    set clipboard+=unnamedplus

" tabs and indent
    set expandtab
    set shiftwidth=4
    set autoindent

" "Replace all" command mapped to S
    nnoremap S :%s//g<left><left>
