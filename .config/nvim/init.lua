--    _       _ __    __
--   (_)___  (_) /_  / /_  ______ _
--  / / __ \/ / __/ / / / / / __ `/
-- / / / / / / /__ / / /_/ / /_/ /
--/_/_/ /_/_/\__(_)_/\__,_/\__,_/
--                zero dependencies

-------------
-- OPTIONS --
-------------

local opt = vim.opt

opt.shadafile = '.local/share/nvim/viminfo' -- viminfo file path from ~
opt.mouse = 'a' -- mouse interaction
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.hlsearch = false -- don't highlight all matches for search
opt.ignorecase = true -- case insensitive seatch
opt.smartcase = true -- don't ignore case when search contains upper case
opt.wrap = false -- disable line wrapping
opt.expandtab = true -- insert spaces for tabs
opt.tabstop = 4 -- number of spaces a tab equals
opt.shiftwidth = 4 -- number of spaces for indentation
opt.smartindent = true -- automatically indent new lines
opt.hidden = true -- allow opening new buffers without saving file
opt.cursorline = true -- highlight current line
-- opt.guicursor = '' -- disable cursor changes for different modes
opt.laststatus = 0 -- hide status line
opt.updatetime = 300 -- decrease update time
opt.completeopt = 'menuone,noselect' -- better completion experience
opt.timeoutlen = 2000 -- more time for hotkeys

---------------
-- VARIABLES --
---------------

local g = vim.g

g['loaded_matchparen'] = 1 -- disable highlighing matching parenthesies
g.mapleader = ',' -- change the <leader> key to be comma

-----------------
-- KEYBINDINGS --
-----------------

local keymap = vim.api.nvim_set_keymap
-- keymap('mode', 'keymap', 'mapped to', {options})
local silent = { silent = true }

keymap('n', '<Leader>s', ':%s//g<left><left>', {}) -- replace all occurrences
keymap('n', '<Leader>h', ':browse oldfiles<CR>', {}) -- file history
keymap('n', '<Leader>o', ':Lexplore<CR>', silent) -- open file manager 
keymap('n', '<Leader>c', ':e $MYVIMRC<CR>', silent) -- edit the config file 
keymap('n', '<Leader><Leader>', ':buffers<CR>:b<Space>', {}) -- open buffers
keymap('n', '<leader>q', ':bd<CR>', silent) -- close current buffer
keymap('n', '<Leader>r', ':source $MYVIMRC<CR>', silent) -- reload config
keymap('n', '<Leader>n', ':call v:lua.toggle_numbers()<CR>', silent)
keymap('n', '<Leader>l', ':call v:lua.toggle_column()<CR>', silent)

-- move between window splits
keymap('n', '<C-h>', ':wincmd h<CR>', silent)
keymap('n', '<C-j>', ':wincmd j<CR>', silent)
keymap('n', '<C-k>', ':wincmd k<CR>', silent)
keymap('n', '<C-l>', ':wincmd l<CR>', silent)

-- move between open buffers
keymap('n', '<A-J>', ':bnext<CR>', silent)
keymap('n', '<A-K>', ':bprev<CR>', silent)

function _G.toggle_numbers()
    vim.wo.number = not vim.wo.number
    vim.wo.relativenumber = not vim.wo.relativenumber
end

function _G.toggle_column()
    if( vim.wo.colorcolumn ~= '' )
    then
        vim.wo.colorcolumn = ''
    else
        vim.wo.colorcolumn = '80'
    end
end

------------   
-- COLORS --
------------

local cmd = vim.cmd

-- tweaks
cmd[[highlight Normal ctermfg=NONE ctermbg=NONE]]
cmd[[highlight CursorLine ctermbg=NONE cterm=NONE]]
cmd[[highlight Comment ctermbg=NONE ctermfg=8]]
cmd[[highlight Visual ctermbg=0 ctermfg=NONE]]
cmd[[highlight Special ctermbg=NONE ctermfg=NONE]]
cmd[[highlight StatusLine ctermbg=4 ctermfg=0 cterm=bold]]
cmd[[highlight StatusLineNC ctermbg=0 ctermfg=0]]
cmd[[highlight LineNr ctermbg=NONE ctermfg=8]]
cmd[[highlight CursorLineNr ctermbg=NONE ctermfg=NONE cterm=bold]]
cmd[[highlight TabLineFill ctermbg=NONE ctermfg=0]]
cmd[[highlight TabLine ctermbg=7 ctermfg=0 cterm=reverse]]
cmd[[highlight TabLineSel ctermbg=8 ctermfg=NONE]]
cmd[[highlight ColorColumn ctermbg=0]]
cmd[[highlight Visual ctermbg=0 ctermfg=NONE]]
cmd[[highlight TODO ctermbg=8 ctermfg=NONE cterm=bold]]

---------------
-- VIMSCRIPT --
---------------

-- workaround for cmdheight being wrong on launch in some cases
vim.api.nvim_exec(
    [[
    autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
    ]],
    false
)

-- highlight on yank
vim.api.nvim_exec(
    [[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
    ]],
    false
)

----------------
-- STATUSLINE --
----------------

local function right_separated(str)
    local sep = ' \\ '
    if( str ~= '' )
    then
        return sep .. str
    end
    return '' 
end

local function sometimes_empty(bool, str)
    if( bool )
    then
        return str 
    end 
    return ''
end

function _G.status_line()
    return table.concat {
        sometimes_empty(vim.bo.readonly, ' [RO]'),
        " %t",
        sometimes_empty(vim.bo.modified, ' [+]'),
        "%=", -- right align
        vim.bo.fileformat,
        right_separated(vim.bo.fileencoding),
        right_separated(vim.bo.filetype),
        right_separated("ln:%l,col:%c %p%% "),
    }
end

vim.o.statusline = "%!luaeval('status_line()')"
