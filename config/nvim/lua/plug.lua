-- [[ plug.lua ]]

return require('packer').startup(function()
-- [[PLUGINS]]

-- [[FILESYSTEM NAVIGATION]]
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons' -- filesystem icons
    }  

-- [[THEME]]
    use { 'mhinz/vim-startify' }                       -- start screen
    use { 'DanilaMihailov/beacon.nvim' }               -- cursor jump
    use {
        'nvim-lualine/lualine.nvim',                     -- statusline
        requires = {'kyazdani42/nvim-web-devicons',
    opt = true}
    }
    use { 'Mofiqul/dracula.nvim' }                     -- colorscheme

-- [[DEV]]
    use {
        'nvim-telescope/telescope.nvim',                 -- fuzzy finder
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'majutsushi/tagbar' }                        -- code structure
    use { 'Yggdroot/indentLine' }                      -- see indentation
    use { 'tpope/vim-fugitive' }                       -- git integration
    use { 'junegunn/gv.vim' }                          -- commit history
    use { 'windwp/nvim-autopairs' }                    -- auto close brackets, etc.
    use { 'tpope/vim-surround' }                       -- modify surroundings pairs 
    use { 'voldikss/vim-floaterm' }                    -- floating terminal within nvim 
end
)
