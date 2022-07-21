--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap


-- Vanila NVIM custom keybindings

-- remap the key used to leave insert mode
map('i', 'jk', '<esc>', {})
-- make space in normal mode press ':' 
map('n', '<space>', ':', {})


-- PLUGIN Keybindings

-- TOGGLE PLUGINS
map('n', ';t', [[:NvimTreeToggle]], {})
map('n', ';l', [[:IndentLinesToggle]], {})
map('n', ';b', [[:TagbarToggle]], {})
map('n', ';f', [[:Telescope find_files]], {})


-- jump to nvim-tree
--map('n', '<mapleader>m', '<ctrl>ww', {})
