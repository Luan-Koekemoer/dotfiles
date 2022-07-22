--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"

-- IMPORTS
require('vars') -- Variables
require('opts') -- Options
require('keys') -- Keymaps
require('plug') -- Plugins
-- require('icons')     -- Icons for Programming

-- PLUGIN CONFIGS
require('plugconf/autopairs')
require('plugconf/cmp')
require('plugconf/lsp')
require('plugconf/lualine')
require('plugconf.gitsigns')
require('plugconf/tree')
require('plugconf/treesitter')
require('plugconf.bufferline')
require('plugconf/comment')
require('plugconf/toggleterm')
