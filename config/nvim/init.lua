--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"

-- IMPORTS
require("vars") -- Variables
require("opts") -- Options
require("keys") -- Keymaps 
require("plug") -- Plugins
-- require('icons')     -- Icons for Programming

-- load lsp configuration
require("lsp")

require("custom.tags") -- :RefreshPyTags + per-project 'tags'
require("custom.kitty") -- suppress kitty's cursor_trail inside nvim

vim.opt.clipboard = "unnamedplus"
