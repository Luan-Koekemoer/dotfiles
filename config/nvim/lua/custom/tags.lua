--[[ tags.lua ]]
--
-- Python ctags index: ~/.tags/<project>, resolved per project. Feeds <C-]>/:tag,
-- Tagbar (<leader>b) and Telescope's tag picker (<leader>ft) -- not the LSP.

local TAGS_DIR = vim.fn.expand("~/.tags")

local EXCLUDES = {
	".git",
	".mypy_cache",
	".pytest_cache",
	"__pycache__",
	"node_modules",
	"migrations",
	"static",
	"staticfiles",
	"media",
	"locale",
	"build",
	"dist",
	".venv",
	"venv",
}

-- Apple's BSD ctags at /usr/bin/ctags cannot read Python and rejects these options.
local function ctags_bin()
	for _, name in ipairs({ "ctags-universal", "uctags", "ctags" }) do
		local path = vim.fn.exepath(name)
		if path ~= "" and path ~= "/usr/bin/ctags" then
			return path
		end
	end
	-- Homebrew does link ctags into its bin, but /usr/bin comes first on PATH here,
	-- so the loop above only ever resolves Apple's BSD ctags. Look it up directly.
	for _, path in ipairs({ "/opt/homebrew/bin/ctags", "/usr/local/bin/ctags" }) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
	return nil
end

local function project_root()
	local from = vim.fn.expand("%:p:h")
	if from == "" or vim.bo.buftype ~= "" then
		from = vim.fn.getcwd()
	end
	local git = vim.fs.find(".git", { path = from, upward = true })[1]
	return git and vim.fs.dirname(git) or vim.fn.getcwd()
end

local function tags_path(root)
	return TAGS_DIR .. "/" .. vim.fn.fnamemodify(root, ":t")
end

local applied_root
local function apply_tags(root)
	if root ~= applied_root then
		applied_root = root
		vim.opt.tags = { tags_path(root), "./tags;" }
	end
end

local function refresh(root)
	local bin = ctags_bin()
	if not bin then
		vim.notify("RefreshPyTags: no usable ctags on PATH (brew install universal-ctags)", vim.log.levels.ERROR)
		return
	end

	vim.fn.mkdir(TAGS_DIR, "p")

	local out = tags_path(root)
	local tmp = out .. ".tmp"

	local cmd = { bin, "--languages=Python", "--python-kinds=-i", "--extras=+q", "--recurse", "-f", tmp }
	for _, dir in ipairs(EXCLUDES) do
		table.insert(cmd, "--exclude=" .. dir)
	end
	table.insert(cmd, root)

	vim.notify("RefreshPyTags: indexing " .. root .. " ...")
	vim.system(cmd, { text = true }, function(res)
		vim.schedule(function()
			if res.code ~= 0 then
				vim.fn.delete(tmp)
				local why = (res.stderr ~= "" and res.stderr) or ("exit " .. res.code)
				vim.notify("RefreshPyTags failed: " .. why, vim.log.levels.ERROR)
				return
			end
			-- Atomic swap: a <C-]> mid-refresh must not read a half-written file.
			local ok, err = vim.uv.fs_rename(tmp, out)
			if not ok then
				vim.notify("RefreshPyTags: could not move tags into place: " .. tostring(err), vim.log.levels.ERROR)
				return
			end
			applied_root = nil
			apply_tags(root)
			vim.notify(("RefreshPyTags: %s (%.0f KB)"):format(out, vim.fn.getfsize(out) / 1024))
		end)
	end)
end

vim.api.nvim_create_user_command("RefreshPyTags", function()
	refresh(project_root())
end, { desc = "Regenerate the Python ctags index for the current project" })

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
	group = vim.api.nvim_create_augroup("PyTags", { clear = true }),
	callback = function()
		apply_tags(project_root())
	end,
})

apply_tags(project_root())
