" INSTALLING VIMPLUG
" TODO: remove autoinstalling vimplug
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" PLUGINS

    " --- specify a directory for plugins
    call plug#begin(stdpath('data') . '/plugged')

    " --- fuzzy finder 
    Plug 'junegunn/fzf.vim'

    " --- auto double brackets
    Plug 'jiangmiao/auto-pairs'

    " --- auto comment
    Plug 'preservim/nerdcommenter' 

    " --- distraction free writing
    Plug 'junegunn/goyo.vim' 

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
    "set relativenumber

    " --- settings for search
    set nohlsearch
    set smartcase

    " --- traverse lines with arrow keys
    set whichwrap=b,s,<,>,[,]

    " --- disable line wrapping
    set nowrap

    " --- tabs and indents
    set expandtab
    set shiftwidth=4
    set autoindent
    set tabstop=4

    " --- ruler
    set colorcolumn=80

    " --- allow opening new buffers without saving file
    set hidden

    " --- disable highlighing of matching parenthesies
    let g:loaded_matchparen=1

    " --- highlight current line
    set cursorline

    " --- disable cursor changes
    set guicursor=

" KEYBOARD SHORTCUTS

    let mapleader=','

    " --- replace all occurrences
    nmap S :%s//g<left><left>

    " --- list open buffers and edit selected 
    "nmap <Leader><Leader> :buffers<CR>:b<Space>
    nmap <silent> <Leader><Leader> :Buffers<CR>

    "--- open recent files
    nmap <silent> <Leader>o :History<CR>

    " --- move up and down among buffers
    nmap <silent> <C-J> :bnext<CR>
    nmap <silent> <C-K> :bprev<CR>

    " --- close open buffer
    nmap <silent> <leader>q :bd<CR>

    " --- reload configuration file
    nmap <silent> <Leader>r :source $MYVIMRC<CR>

    " --- insert empty lines above/below
    nmap <silent> <CR> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nmap <silent> <leader><CR> :set paste<CR>m`O<Esc>``:set nopaste<CR>

    " --- scroll up and down with arrowkeys
    nmap <Down> <C-e>
    nmap <Up> <C-y>

    " toggle distraction free writing
    nmap <silent> <leader>w :Goyo<CR>

" STATUSLINE

    set statusline=

    " --- file name
    set statusline+=%#TabLineSel#
    set statusline+=%{&modified?'\ \ +':''}
    set statusline+=\ %t\ 
    set statusline+=%*

    " --- line numbers
    set statusline+=\ %l,%c%V

    " --- right align
    set statusline+=%=

    " --- file type
    set statusline+=%y

    " --- file encoding
    set statusline+=\ %{&fileencoding?&fileencoding:&encoding}

    " --- file format
    set statusline+=\(%{&fileformat}\)

    " --- number of lines
    set statusline+=\ %L

    " --- buffer number
    set statusline+=\ %#TabLineSel#
    set statusline+=\ %n\ 

" FZF SETTINGS

    " --- layout
    let g:fzf_layout = { 'down': '50%' }

    " --- remove preview window
    let g:fzf_preview_window = []

    " --- remove statusbar and other elements in fzf window
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler number relativenumber


" GOYO SETTINGS
    
    function! s:goyo_enter()
        " TODO implement so that it clears previous command text and goes to
        " the top of the file
        set wrap
        set breakindent
    endfunction
    autocmd! User GoyoEnter nested call <SID>goyo_enter()

    function! s:goyo_leave()
        set nowrap
    endfunction
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

    let g:limelight_conceal_ctermfg = 243

" COLORS

    filetype plugin on
    syntax on
    syntax reset
    highlight clear
    set background=dark

    " TODO: add a precmd so that goyo and other plugins don't remove custom
    " highlights
    hi Normal ctermfg=NONE ctermbg=NONE
    hi CursorLine ctermbg=NONE cterm=NONE
    hi Comment ctermbg=NONE ctermfg=8
    hi Visual ctermbg=0 ctermfg=NONE
    hi Special ctermbg=NONE ctermfg=NONE
    hi StatusLine ctermbg=7 ctermfg=0 cterm=reverse
    hi StatusLineNC ctermbg=8 ctermfg=0 cterm=reverse
    hi LineNr ctermbg=NONE ctermfg=8
    hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=bold
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLine ctermbg=7 ctermfg=0 cterm=reverse
    hi TabLineSel ctermbg=8 ctermfg=NONE
    hi ColorColumn ctermbg=0
    hi TODO ctermbg=8 ctermfg=NONE cterm=bold
