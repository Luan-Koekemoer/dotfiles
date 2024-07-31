local autopairs = {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    }
}

local commenter = {
    "numToStr/Comment.nvim",
    opts = {
        pre_hook = function(ctx)
            local U = require("Comment.utils")

            local location = nil
            if ctx.ctype == U.ctype.block then
                location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
                key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                location = location,
            })
        end,
    }
}

local deleteBuffers = { "moll/vim-bbye" }

local vimSurround = { "tpope/vim-surround" }
local smartComment = { "JoosepAlviste/nvim-ts-context-commentstring", requires = "nvim-treesitter/nvim-treesitter" }
return { autopairs, commenter, deleteBuffers, vimSurround, smartComment }
