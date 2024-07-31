local NvimTree = {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}

local TagBar = { "preservim/tagbar" }
local IntegratedTerminal = {
    "akinsho/toggleterm.nvim",
    opts = {
        size = 30,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    }
}


local bufferLine = {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    opts = {
        options = {
            numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            close_command = "Bdelete! %d",
            right_mouse_command = "Bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = { icon = "▎" },
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 30,
            max_prefix_length = 30,
            tab_size = 21,
            diagnostics = true, -- | "nvim_lsp" | "coc",
            diagnostics_update_in_insert = false,
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = true,
            always_show_bufferline = true,
        },
    }
}


local startScreen = { "mhinz/vim-startify" }

return {
    NvimTree, TagBar, IntegratedTerminal, bufferLine, startScreen }
