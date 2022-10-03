-- [[ plug.lua ]]
return require("packer").startup(function(use)
	-- [[PLUGINS]]
	use ({"wbthomason/packer.nvim"}) -- this is essential.

	-- [[FILESYSTEM NAVIGATION]]
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }) -- filesystem icons

	-- [[THEME]]
	use({ "mhinz/vim-startify" }) -- start screen
	use({ "DanilaMihailov/beacon.nvim" }) -- cursor jump
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }) --lualine
	use({ "Mofiqul/dracula.nvim" }) -- colorscheme
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- tree parser and syntax highlighting
	use({ "p00f/nvim-ts-rainbow" })
	use({ "norcalli/nvim-colorizer.lua" })
	-- [[DEV]]

	-- telescope and extentions for telescope
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } }) -- fuzzy

	use({ "majutsushi/tagbar" }) -- code structure
	use({ "Yggdroot/indentLine" }) -- see indentation
	use({ "windwp/nvim-autopairs" }) -- auto close brackets, etc.
	use({ "tpope/vim-surround" }) -- modify surroundings pairs
	use({ "akinsho/toggleterm.nvim" }) -- floating terminal within nvim
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }) -- buffer lines for opening multiple files
	use({ "moll/vim-bbye" }) --deleting buffersk
	use({ "numToStr/Comment.nvim" }) --commenting fucntionality
	use({ "JoosepAlviste/nvim-ts-context-commentstring", requires = "nvim-treesitter/nvim-treesitter" }) --smart commenting for langs with mutli comment styles
	-- [[GIT]]
	use({ "junegunn/gv.vim" }) -- commit history (:GV)
	use({ "tpope/vim-fugitive" }) -- git integration (:G)
	use({ "lewis6991/gitsigns.nvim" }) -- git signs to show detials of modified lines
	use({ "ThePrimeagen/git-worktree.nvim" }) --A simple wrapper around git worktree operations, create, switch, and delete
	-- [[AUTOCOMPLETION]]
	use({ "hrsh7th/nvim-cmp",  requires="nvim-treesitter/nvim-treesitter"}) --Path completions
	use({ "hrsh7th/cmp-buffer" }) --Buffer completions
	use({ "hrsh7th/cmp-path" }) --Path completions
	use({ "hrsh7th/cmp-cmdline" }) --cmdline completions
	use({ "hrsh7th/cmp-nvim-lsp" }) --The completion plugin
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "ray-x/lsp_signature.nvim" }) -- Function signatures

	-- [[SNIPPETS]]
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" }) --Pack with plenty of snippet support

	 -- [[LSP]] 
	use({ "neovim/nvim-lspconfig" }) -- neovim lsp support
	use({ "williamboman/nvim-lsp-installer" }) -- Installs lspconfig
	use({ "jose-elias-alvarez/null-ls.nvim" }) --provides formatting support
end)
