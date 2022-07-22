-- [[ plug.lua ]]

return require('packer').startup(function()
-- [[PLUGINS]]

-- [[FILESYSTEM NAVIGATION]]
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'    -- filesystem icons
  }  

-- [[THEME]]
  use { 'mhinz/vim-startify' }                  -- start screen
  use { 'DanilaMihailov/beacon.nvim' }          -- cursor jump
  use {
    'nvim-lualine/lualine.nvim',                -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
  opt = true}
  }
  use { 'Mofiqul/dracula.nvim' }                -- colorscheme  
  use { 'nvim-treesitter/nvim-treesitter' }     -- tree parser and syntax highlighting
  use { 'p00f/nvim-ts-rainbow' }

-- [[DEV]]
  use {
    'nvim-telescope/telescope.nvim',            -- fuzzy finder
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'majutsushi/tagbar' }                   -- code structure
  use { 'Yggdroot/indentLine' }                 -- see indentation
  use { 'tpope/vim-fugitive' }                  -- git integration
  use { 'junegunn/gv.vim' }                     -- commit history
  use { 'windwp/nvim-autopairs' }               -- auto close brackets, etc.
  use { 'tpope/vim-surround' }                  -- modify surroundings pairs 
  use { 'voldikss/vim-floaterm' }               -- floating terminal within nvim 


-- [[AUTOCOMPLETION]] 
  use { 'hrsh7th/nvim-cmp' }                    --Path completions
  use { 'hrsh7th/cmp-buffer' }                  --Buffer completions
  use { 'hrsh7th/cmp-path' }                    --Path completions
  use { 'hrsh7th/cmp-cmdline' }                 --cmdline completions
  use { 'hrsh7th/cmp-nvim-lsp' }                --The completion plugin
  use { 'hrsh7th/cmp-nvim-lua' }
-- [[SNIPPETS]]
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }        --Pack with plenty of snippet support

-- [[LSP]]
  use { 'neovim/nvim-lspconfig' }                 -- neovim lsp support
  use { 'williamboman/nvim-lsp-installer' }     -- Installs lspconfig


end
)
