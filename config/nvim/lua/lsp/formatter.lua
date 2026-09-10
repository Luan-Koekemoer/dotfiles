local status_ok, conform = pcall(require, "conform")
if not status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
	},
	format_on_save = nil,
})

conform.formatters.python = {
	prepend_args = { "--line-length", "120", "--target-version=py310" },
}

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		--require("conform").format({ bufnr = args.buf })
	end,
})

local theme_name = "zephyr"
local status_ok, theme = pcall(require, theme_name)
if not status_ok then
	return
end
