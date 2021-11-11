--    _       _ __    __
--   (_)___  (_) /_  / /_  ______ _
--  / / __ \/ / __/ / / / / / __ `/
-- / / / / / / /__ / / /_/ / /_/ /
--/_/_/ /_/_/\__(_)_/\__,_/\__,_/
--

-- dependencies
-- * packer plugin manager
-- * fzf fuzzy finder

-- shorthands
local opt = vim.opt
local g = vim.g
local keymap = vim.api.nvim_set_keymap
local cmd = vim.cmd

-------------
-- PLUGINS --
-------------

require('packer').startup(
    function()
        use 'vijaymarupudi/nvim-fzf' -- fzf lua implementation
        use 'lukas-reineke/indent-blankline.nvim' -- indent guides
        use 'ggandor/lightspeed.nvim' -- fast navigation
        use 'b3nj5m1n/kommentary' -- comment text in and out
    end
)

-- nvim-fzf initialization
cmd('unlet $FZF_DEFAULT_OPTS') -- clearing options that may be set in env 
local fzf = require('fzf')
local fzf_arg = '--border=rounded --cycle --color=16,bg+:-1,prompt:5,pointer:4'
require('fzf').default_options = { fzf_cli_args = fzf_arg }

-------------
-- OPTIONS --
-------------

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
opt.laststatus = 0 -- show/hide status line
-- opt.showmode = false -- disable showing mode below statusline
opt.updatetime = 300 -- decrease update time
opt.completeopt = 'menuone,noselect' -- better completion experience
opt.timeoutlen = 2000 -- more time for hotkeys

g['loaded_matchparen'] = 1 -- disable highlighing matching parenthesies
g.mapleader = ',' -- change the <leader> key to be comma

-- disable auto comment
opt.formatoptions = opt.formatoptions - "o"
opt.formatoptions = opt.formatoptions - "r"
opt.formatoptions = opt.formatoptions - "c"

----------------------
-- CUSTOM FUNCTIONS --
----------------------

-- file history with fzf (requires fzf variable to be set)
function _G.history()
    coroutine.wrap(function()
        vim.cmd('below new')
        local result = fzf.provided_win_fzf(vim.v.oldfiles)
        if result then
            vim.cmd('edit '.. result[1])
        end
    end)()
end

--  toggle line numbers
function _G.toggle_numbers()
    vim.wo.number = not vim.wo.number
end

-- toggle ruler
function _G.toggle_column()
    if( vim.wo.colorcolumn ~= '' )
    then
        vim.wo.colorcolumn = ''
    else
        vim.wo.colorcolumn = '80'
    end
end

-----------------
-- KEYBINDINGS --
-----------------

local silent = { silent = true }

-- keymap('mode', 'keymap', 'mapped to', {options})
keymap('n', '<Leader>s', ':%s//g<left><left>', {}) -- replace all occurrences
keymap('n', '<Leader>o', '<cmd>lua history()<CR>', silent) -- file history
keymap('n', '<Leader>f', ':Files<CR>', silent) -- open file manager 
keymap('n', '<Leader>e', ':e $MYVIMRC<CR>', silent) -- edit the config file 
keymap('n', '<Leader><Leader>', ':buffers<CR>:b<Space>', {}) -- open buffers
keymap('n', '<Leader>q', ':bd<CR>', {}) -- open buffers
keymap('n', '<Leader>r', ':source $MYVIMRC<CR>', silent) -- reload config
keymap('n', '<Leader>n', '<cmd>lua toggle_numbers()<CR>', silent)
keymap('n', '<Leader>l', '<cmd>lua toggle_column()<CR>', silent)

-- move between window splits
keymap('n', '<C-h>', ':wincmd h<CR>', silent)
keymap('n', '<C-j>', ':wincmd j<CR>', silent)
keymap('n', '<C-k>', ':wincmd k<CR>', silent)
keymap('n', '<C-l>', ':wincmd l<CR>', silent)

-- move between open buffers
keymap('n', '<A-j>', ':bnext<CR>', silent)
keymap('n', '<A-k>', ':bprev<CR>', silent)

-- Getting color highlight groups (for creating color schemes)
vim.api.nvim_exec(
    [[function! SynGroup()
        let l:s = synID(line('.'), col('.'), 1)
        echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
    endfun
    nnoremap <silent> <F3> :call SynGroup()<CR>]],
    false
)

------------   
-- COLORS --
------------

cmd('colorscheme bedsi')

---------------
-- VIMSCRIPT --
---------------

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
