--     _       _ __    __
--    (_)___  (_) /_  / /_  ______ _
--   / / __ \/ / __/ / / / / / __ `/
--  / / / / / / /__ / / /_/ / /_/ /
-- /_/_/ /_/_/\__(_)_/\__,_/\__,_/
-- A less broken neovim experience in one file!
--

-- Dependencies:
-- * packer plugin manager
-- * fzf fuzzy finder binary

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

        -- better language parsers (mostly for improved syntax highlighting):
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    end
)

-- nvim-fzf initialization
cmd('unlet $FZF_DEFAULT_OPTS') -- clearing options that may be set in env 
local nvim_fzf = require('fzf')
local fzf_arg = '--border=rounded --cycle --color=16,bg+:-1,prompt:5,pointer:4'
require('fzf').default_options = { fzf_cli_args = fzf_arg }

-- tree-sitter initialization
require'nvim-treesitter.configs'.setup {
    highlight = {
    enable = true,
    },
}

--------------
-- SETTINGS --
--------------

opt.mouse = 'a' -- mouse interaction
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.hlsearch = false -- highlight all matches for search
opt.ignorecase = true -- case insensitive seatch
opt.smartcase = true -- ignore case when search contains upper case
opt.wrap = false -- disable line wrapping
opt.expandtab = true -- insert spaces for tabs
opt.tabstop = 4 -- number of spaces a tab equals
opt.shiftwidth = 4 -- number of spaces for indentation
opt.smartindent = true -- automatically indent new lines
-- opt.guicursor = '' -- disable cursor changes for different modes
opt.laststatus = 0 -- show/hide status line
opt.showmode = true -- showing mode below statusline
opt.updatetime = 300 -- decrease update time for faster feel
opt.completeopt = 'menuone,noselect' -- better completion experience
opt.timeoutlen = 2000 -- more time for leader hotkeys
opt.scrolloff = 10 -- start moving buffer as cursor reaches x lines
-- opt.list = true -- symbols for spaces and end of line

g['loaded_matchparen'] = 1 -- disable highlighing matching parenthesies
g.mapleader = ',' -- change the <leader> key to be comma

-- enabling highlight on yank
vim.api.nvim_exec(
    [[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
    ]],
    false
)

----------------------
-- CUSTOM FUNCTIONS --
----------------------

-- template for fzf functionality with nvim-fzf
-- requires fzf variable to be set (nvim_fzf)
-- Parameters:
-- * cmd_src = items to display in fzf
-- * cmd_act = vim command to use on selected item
function _G.fzf_template(cmd_src, cmd_act)
    coroutine.wrap(function()
        vim.cmd('below new')
        vim.wo.number = false
        vim.opt.showmode = false
        local result = nvim_fzf.provided_win_fzf(cmd_src)
        if result then
            vim.cmd(cmd_act .. ' ' .. result[1])
        end
    end)()
end

function _G.fzf_history()
    fzf_template(vim.v.oldfiles, 'edit')
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
        vim.wo.colorcolumn = '81'
    end
end

-----------------
-- KEYBINDINGS --
-----------------

-- keymap('mode', 'keymap', 'mapped to', {options})

local silent = { silent = true }

keymap('n', '<Leader>s', ':%s//g<left><left>', {}) -- replace all occurrences
keymap('n', '<Leader>e', ':e $MYVIMRC<CR>', silent) -- edit config file 
keymap('n', '<Leader><Leader>', ':buffers<CR>:b<Space>', {}) -- open buffers
keymap('n', '<Leader>q', ':bd<CR>', {}) -- close buffer
keymap('n', '<Leader>r', ':source $MYVIMRC<CR>', silent) -- reload config
keymap('n', '<Leader>n', '<cmd>lua toggle_numbers()<CR>', silent) -- line nums
keymap('n', '<Leader>l', '<cmd>lua toggle_column()<CR>', silent) --ruler
keymap('n', '<Leader>o', '<cmd>lua fzf_history()<CR>', silent) -- file history

-- move between window splits
keymap('n', '<C-h>', ':wincmd h<CR>', silent)
keymap('n', '<C-j>', ':wincmd j<CR>', silent)
keymap('n', '<C-k>', ':wincmd k<CR>', silent)
keymap('n', '<C-l>', ':wincmd l<CR>', silent)

-- move between open buffers
keymap('n', '<A-j>', ':bnext<CR>', silent)
keymap('n', '<A-k>', ':bprev<CR>', silent)

------------   
-- COLORS --
------------

cmd([[
    highlight clear
    syntax reset

    highlight TSProperty ctermfg=4
    highlight TSNumber ctermfg=4
    highlight TSKeyword ctermfg=1
    highlight TSInclude ctermfg=1
    highlight TSKeywordFunction ctermfg=1
    highlight TSConstBuiltin ctermfg=4
    highlight TSTag ctermfg=3
    highlight TSProperty ctermfg=4
    highlight TSNumber ctermfg=4
    highlight TSKeyword ctermfg=4
    highlight TSInclude ctermfg=1
    highlight TSKeywordFunction ctermfg=1
    highlight TSConstBuiltin ctermfg=4
    highlight TSTag ctermfg=3
    highlight TSFunction ctermfg=13
    highlight TSString ctermfg=2
    highlight TSComment ctermfg=8
    highlight TSNumber ctermfg=4
    highlight TSType ctermfg=4
    highlight TSVariable ctermfg=NONE
    highlight TSPunctBracket ctermfg=NONE
    highlight TSPunctSpecial ctermfg=NONE
    highlight TSPunctDelimiter ctermfg=NONE

    highlight Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
    highlight Visual ctermbg=0 ctermfg=NONE
    highlight LineNr ctermbg=NONE ctermfg=0
    highlight TabLineFill ctermbg=NONE ctermfg=0
    highlight TabLine ctermbg=7 ctermfg=0 cterm=reverse
    highlight TabLineSel ctermbg=8 ctermfg=NONE
    highlight StatusLine ctermbg=0 ctermfg=NONE cterm=NONE
    highlight StatusLineNC ctermbg=0 ctermfg=0 cterm=NONE
    highlight VertSplit ctermbg=0 ctermfg=8 cterm=NONE
    highlight Visual ctermbg=0 ctermfg=NONE
    highlight TODO ctermbg=8 ctermfg=NONE cterm=bold

    highlight IndentBlanklineChar ctermfg=0
]])
