-- nvim-treesitter `main` branch (required for Neovim 0.12).
--
-- The `nvim-treesitter.configs` module only exists on the frozen `master` branch
-- and is gone here. Highlighting and indenting are now driven by core
-- `vim.treesitter` instead of a `setup()` table, so this file wires them to a
-- FileType autocmd rather than declaring `highlight = { enable = true }`.
local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	return
end

local ensure_installed = {
	"bash",
	"c",
	"diff",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"printf",
	"python",
	"query",
	"regex",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

ts.setup({})

-- Replaces master's `ensure_installed` + `auto_install`. install() is async and
-- skips parsers that are already present, so this is cheap on every startup.
ts.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang then
			return
		end
		-- Starting the highlighter for a filetype whose parser is not installed is
		-- exactly what produces highlighter stack traces, so confirm it loads first.
		local added_ok, added = pcall(vim.treesitter.language.add, lang)
		if not (added_ok and added) then
			return
		end
		vim.treesitter.start(ev.buf, lang)
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Dropped in the move off `master`, both deliberately:
--   * incremental_selection (<C-space> / <bs>) — not part of the main branch.
--   * textobjects ([f, ]c, [a …) — these needed nvim-treesitter-textobjects,
--     which is not installed, so the old config block was already a no-op.
