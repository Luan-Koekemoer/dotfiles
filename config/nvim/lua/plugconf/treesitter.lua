-- For more information run ':h nvim-treesitter-modules'

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"cpp",
		"c_sharp",
		"javascript",
		"css",
		"html",
		"json",
		"java",
		"python",
		"typescript",
	},
	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = true,
	},

	indent = { enable = true, disable = { "yaml" } },

	incremental_selection = {
		enable = true,
	},

	textobjects = {
		enable = true,
	},

	rainbow = {
		enable = true,
		disable = {},
		extended_mode = true,
		max_file_lines = nil,
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
