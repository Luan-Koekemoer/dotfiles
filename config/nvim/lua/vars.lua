--[[ vars.lua ]]

local g = vim.g
g.t_co = 256
g.background = "dark"

-- Update the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path


-- PLUGINS
-- floaterm config
g.floaterm_keymap_new    = '<F7>'
g.floaterm_keymap_prev   = '<F8>'
g.floaterm_keymap_next   = '<F9>'
g.floaterm_keymap_toggle = '<F12>'
