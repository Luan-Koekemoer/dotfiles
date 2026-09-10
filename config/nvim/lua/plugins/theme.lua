return {
	{ "Yggdroot/indentLine" },
	{ "Mofiqul/dracula.nvim" },
	--{ "danilamihailov/beacon.nvim" },
	{
		"glepnir/zephyr-nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", opt = true },
	},
	--{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	--	{ "mhartington/oceanic-next" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = { theme = "dracula" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
	-- {
	--   "LazyVim/LazyVim",
	--   opts = {
	--     colorscheme = "dracula",
	--   },
	-- },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
