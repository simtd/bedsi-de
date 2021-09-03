" INSTALLING VIMPLUG
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" PLUGINS
    " --- specify a directory for plugins
    call plug#begin(stdpath('data') . '/plugged')

    " --- fzf implementations plugin
    Plug 'junegunn/fzf.vim'

    " --- auto double brackets plugin
    Plug 'jiangmiao/auto-pairs'

    " --- auto comment out portions of text
    Plug 'preservim/nerdcommenter' 

    " --- initialize plugin system
    call plug#end()

" GENERAL SETTINGS
    " --- viminfo file path
    set viminfo+=n~/.config/nvim/viminfo
    " --- mouse interaction
    set mouse=a
    " --- use system clipboard
    set clipboard+=unnamedplus
    " --- line numbers
    set number
    set relativenumber
    " --- settings for search
    set nohlsearch
    set smartcase
    " --- traverse lines with arrow keys
    set whichwrap=b,s,<,>,[,]
    " --- disabling line wrapping
    set nowrap
    " --- tabs and indents
    set expandtab
    set shiftwidth=4
    set autoindent
    set tabstop=4
    " --- ruler
    set colorcolumn=80
    " --- allowing opening new buffers without saving file
    set hidden
    " --- disabling highlighing of matching parenthesies
    let g:loaded_matchparen=1

" KEYBOARD SHORTCUTS
    let mapleader=','
    " --- replace all occurrences
    nmap S :%s//g<left><left>
    " --- list open buffers and edit entered buffer from the list
    nmap <Leader><Leader> :buffers<CR>:b<Space>
    " --- open recent files (requires fzf.vim)
    nmap <silent> <Leader>o :History<CR>
    " --- move up and down among buffers
    nmap <silent> <C-J> :bnext<CR>
    nmap <silent> <C-K> :bprev<CR>
    " --- close open buffer
    nmap <silent> <leader>q :bd<CR>
    " --- reload configuration file
    nmap <silent> <Leader>r :source $MYVIMRC<CR>
    " --- insert empty lines
    nmap <silent> <A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nmap <silent> <A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" STATUSLINE
    set statusline=
    " --- file name
    set statusline+=%#TabLineSel#
    set statusline+=%{&modified?'\ \ +':''}
    set statusline+=\ %t\ 
    set statusline+=%*
    " --- line numbers
    set statusline+=\ [%l/%L]
    " --- right align
    set statusline+=%=
    " --- file type
    set statusline+=%y
    " --- file encoding
    set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
    " --- file format
    set statusline+=\(%{&fileformat}\)
    " --- buffer number
    set statusline+=\ %#TabLineSel#
    set statusline+=\ %n\ 
    
" FZF SETTINGS
    " --- layout
    let g:fzf_layout = { 'down': '50%' }
    " --- removing preview window
    let g:fzf_preview_window = []
    " --- removing statusbar and other elements in fzf window
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler number relativenumber
 
" COLORS
    filetype plugin on
    syntax on
    syntax reset
    highlight clear
    set background=dark
    colorscheme industry
    hi Normal ctermfg=NONE ctermbg=NONE
    hi Comment ctermbg=NONE ctermfg=8
    hi Special ctermbg=NONE ctermfg=NONE
    hi StatusLine ctermbg=7 ctermfg=0 cterm=reverse
    hi StatusLineNC ctermbg=8 ctermfg=0 cterm=reverse
    hi LineNr ctermbg=NONE ctermfg=8
    hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=bold
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLine ctermbg=7 ctermfg=0 cterm=reverse
    hi TabLineSel ctermbg=8 ctermfg=NONE
    hi ColorColumn ctermbg=0
