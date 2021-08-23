" GENERAL
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

" SHORTCUTS
    let mapleader=','
    " --- replace all occurrences
    nmap S :%s//g<left><left>
    " --- select a recent file to open in new buffer (requires fzf)
    nmap <silent> <leader>o :call fzf#run(fzf#wrap({'source': v:oldfiles, 'sink': 'edit'}))<CR>    
    " --- list open buffers and edit entered buffer from the list
    nmap <Leader><Leader> :buffers<CR>:b<Space>
    " --- move among buffers
    nmap <silent> <C-J> :bnext<CR>
    nmap <silent> <C-K> :bprev<CR>
    " --- close open buffer
    nmap <silent> <leader>q :bd<CR>
    " --- reload configuration file
    nmap <silent> <Leader>r :source $MYVIMRC<CR>

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
    hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=bold
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLine ctermbg=7 ctermfg=0 cterm=reverse
    hi TabLineSel ctermbg=8 ctermfg=NONE
    highlight ColorColumn ctermbg=0 guibg=NONE

" STATUSLINE
    set statusline=
    " --- buffer number
    set statusline+=%#TabLineSel#
    set statusline+=\ %n\ 
    set statusline+=%*
    " --- line numbers
    set statusline+=\ [%l/%L]
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
    set statusline+=%{&modified?'\ +':''}
    set statusline+=\ %f\ 

" --- FZF SETTINGS
    " --- layout
    let g:fzf_layout = { 'down': '30%' }
    " -- removing statusbar and other elements in fzf window
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler number relativenumber
