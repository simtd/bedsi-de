--    _       _ __    __
--   (_)___  (_) /_  / /_  ______ _
--  / / __ \/ / __/ / / / / / __ `/
-- / / / / / / /__ / / /_/ / /_/ /
--/_/_/ /_/_/\__(_)_/\__,_/\__,_/
--

-- dependencies:
-- * packer
-- * fzf

-- shorthands
local opt = vim.opt
local g = vim.g
local keymap = vim.api.nvim_set_keymap
local cmd = vim.cmd

-------------
-- PLUGINS --
-------------

require('packer').startup(function()
    use 'junegunn/fzf.vim' -- fuzzy finder
    use 'nvim-lualine/lualine.nvim' -- statusline
end)

-- fzf options
g.fzf_preview_window = ''

-- lualine settings
local custom_16color = require'lualine.themes.16color'
custom_16color.normal.a.fg = 'black' 
custom_16color.insert.a.fg = 'black' 
custom_16color.visual.a.fg = 'black' 
custom_16color.replace.a.fg = 'black' 
custom_16color.inactive.a.fg = 'black' 
require'lualine'.setup{
    options = {
        icons_enabled = false,
        theme = custom_16color,
        component_separators = { left = '|', right = '|'},
        section_separators = '',
    },
}

-------------
-- OPTIONS --
-------------

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
opt.laststatus = 2 -- show/hide status line
opt.showmode = false -- disable showing mode below statusline
opt.updatetime = 300 -- decrease update time
opt.completeopt = 'menuone,noselect' -- better completion experience
opt.timeoutlen = 2000 -- more time for hotkeys

g['loaded_matchparen'] = 1 -- disable highlighing matching parenthesies
g.mapleader = ',' -- change the <leader> key to be comma

-- disable auto comment
opt.formatoptions = opt.formatoptions - "o"
opt.formatoptions = opt.formatoptions - "r"
opt.formatoptions = opt.formatoptions - "c"

-----------------
-- KEYBINDINGS --
-----------------

local silent = { silent = true }

-- keymap('mode', 'keymap', 'mapped to', {options})
keymap('n', '<Leader>s', ':%s//g<left><left>', {}) -- replace all occurrences
keymap('n', '<Leader>o', ':History<CR>', silent) -- file history
keymap('n', '<Leader>f', ':Files<CR>', silent) -- open file manager 
keymap('n', '<Leader>e', ':e $MYVIMRC<CR>', silent) -- edit the config file 
keymap('n', '<Leader><Leader>', ':buffers<CR>:b<Space>', {}) -- open buffers
keymap('n', '<Leader>r', ':source $MYVIMRC<CR>', silent) -- reload config
keymap('n', '<Leader>n', ':call v:lua.toggle_numbers()<CR>', silent)
keymap('n', '<Leader>c', ':call v:lua.toggle_column()<CR>', silent)

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

-- tweaks
cmd[[highlight Normal ctermfg=NONE ctermbg=NONE]]
cmd[[highlight CursorLine ctermbg=NONE cterm=NONE]]
cmd[[highlight Comment ctermbg=NONE ctermfg=2]]
cmd[[highlight Visual ctermbg=0 ctermfg=NONE]]
cmd[[highlight Special ctermbg=NONE ctermfg=NONE]]
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