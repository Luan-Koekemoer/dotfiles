return {
    { "Yggdroot/indentLine" },
    --  { "Mofiqul/dracula.nvim" },
    { 'danilamihailov/beacon.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = { theme = 'dracula' }
        }
    },
    -- {
    --   "LazyVim/LazyVim",
    --   opts = {
    --     colorscheme = "dracula",
    --   },
    -- },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
