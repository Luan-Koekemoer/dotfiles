--[[ opts.lua ]]
local opt = vim.opt
local cmd = vim.api.nvim_command

-- [[ CONTEXT ]]
local options = {
	colorcolumn = "80", -- str:  Show col for max line length
	number = true, -- bool: Show line numbers
	relativenumber = true, -- bool: Show relative line numbers
	scrolloff = 8, -- int:  Context lines you would like to see above and below the cursor
	sidescrolloff = 8, --int

	-- opt.signcolumn = "yes"           -- str:  Show the sign column

	-- [[ FILETYPES ]]
	encoding = "utf8", -- str:  String encoding to use
	fileencoding = "utf8", -- str:  File encoding to use

	-- [[ THEME ]]
	syntax = "ON", -- str:  Allow syntax highlighting
	termguicolors = false, -- bool: If term supports ui color then enable

	-- [[ SEARCH ]]
	ignorecase = true, -- bool: Ignore case in search patterns
	smartcase = true, -- bool: Override ignorecase if search contains capitals
	incsearch = true, -- bool: Use incremental search
	hlsearch = false, -- bool: Highlight search matches

	-- [[ WHITESPACE ]]
	expandtab = true, -- bool: Use spaces instead of tabs
	shiftwidth = 2, -- num:  Size of an indent
	softtabstop = 2, -- num:  Number of spaces tabs count for in insert mode
	tabstop = 2,

	-- [[ SPLITS ]]
	splitright = true, -- bool: Place new window to right of current one
	splitbelow = true, -- bool: Place new window below the current one

	-- [[ SELL CHECKING ]]
  spell = true,
  syn = 'off'
}

vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]]) -- Stop new line comments.

for k, v in pairs(options) do
	opt[k] = v
end

-- [[ THEME ]]
pcall(cmd, "colorscheme dracula")

