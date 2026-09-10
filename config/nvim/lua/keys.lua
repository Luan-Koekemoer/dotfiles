--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--  Vanila NVIM custom keybindings
--  Modes:
--    normal_mode = "n",
--    insert_mode = "i",
--    visual_mode = "v",
--    visual_block_mode = "x",
--    term_mode = "t",
--    command_mode = "c",

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
map("i", "jk", "<ESC>", opts)

function AutoSemi()
	local _, _ = vim.api.nvim_win_get_cursor(0)
	--[[ return "<ESC>A;" + c + "|" ]]
end

-- https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42
--[[ map("i", ";;", "<ESC>A;<ESC>", opts) -- todo: jump to previous spot ]]
map("n", "<leader>;", "A;<ESC>", opts) -- todo: jump to previous spot

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Nvimtree
map("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
map("n", "<leader>dd", ":Bdelete<cr>", opts)
map("n", "<leader>b", ":TagbarToggle<cr>", opts)

-- DAP
--[[ map("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>", opts) ]]
--[[ map("n", "<leader>df", ":lua require('dap-python').test_class()<CR>", opts) ]]
--[[ map("n", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", opts) ]]
map("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<cr>", opts)
map("n", "<leader>dc", ":lua require('dap').continue()<cr>", opts)
map("n", "<leader>di", ":lua require('dap').step_into()<cr>", opts)
map("n", "<leader>do", ":lua require('dap').step_over()<cr>", opts)
map("n", "<leader>du", ":lua require('dap').step_out()<cr>", opts)
map("n", "<leader>dr", ":lua require('dapui').eval(nil, {enter = true})<cr>", opts)
map("n", "<leader>dl", ":lua require('dap').run_last()<cr>", opts)
map(
	"n",
	"<leader>dq",
	":lua require('dap').terminate()<cr> :lua require('dapui').close()<cr> :lua require('nvim-dap-virtual-text').toggle()<cr>",
	opts
)
map("n", "<leader>db", ":lua require('dap').list_breakpoints()<cr>", opts)
map("n", "<leader>de", ":lua require('dap').set_exception_breakpoints({ 'all' })<cr>", opts)
map("n", "<leader>dh", ":lua require('dapui').toggle()<cr>", opts)

--Telescope
map(
	"n",
	"<leader>ff",
	":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
map("n", "<leader>fl", ":lua require('telescope.builtin').live_grep(require('telescope.themes'))<cr>", opts)
map("n", "<leader>fp", ":lua require('telescope.builtin').find_files(require('telescope.themes'))<cr>", opts)
map(
	"n",
	"<leader>fb",
	":lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
map("n", "<leader>fc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", opts) -- requires git-worktree extention
map("n", "<leader>fW", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", opts) -- requires git-worktree extention

-- Word under cursor (the `yiw` then `/<paste>` flow, without the round trip).
local function cword()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		vim.notify("No word under cursor", vim.log.levels.WARN)
	end
	return word
end

-- Yank the visual selection. Both registers are restored afterwards: "vy writes
-- to v *and* repoints the unnamed register at it, so p would paste the selection.
local function vselection()
	local v, v_type = vim.fn.getreg("v"), vim.fn.getregtype("v")
	local unnamed, unnamed_type = vim.fn.getreg('"'), vim.fn.getregtype('"')
	vim.cmd('noautocmd normal! "vy')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", v, v_type)
	vim.fn.setreg('"', unnamed, unnamed_type)
	return text
end

-- Highlight every occurrence in this buffer, cursor stays put so n/N walk the
-- matches. hlsearch is off globally (opts.lua), so turn it on.
local function search_text(text)
	if text == "" then
		return
	end
	-- \V is very-nomagic, so only a literal backslash needs escaping. Real newlines
	-- become the \n atom, which keeps a multi-line selection searchable.
	local pattern = "\\V" .. vim.fn.escape(text, "\\"):gsub("\n", "\\n")
	vim.fn.setreg("/", pattern)
	vim.fn.histadd("search", pattern)
	vim.opt.hlsearch = true
end

vim.keymap.set("n", "<leader>fw", function()
	search_text(cword())
end, { noremap = true, silent = true, desc = "Search/highlight word under cursor" })

vim.keymap.set("x", "<leader>fw", function()
	search_text(vselection())
end, { noremap = true, silent = true, desc = "Search/highlight visual selection" })

-- Same text, but as a Telescope picker over the whole project. ripgrep is
-- line-oriented by default, so a multi-line selection can only use its first line.
local function grep_text(text)
	local first = text:match("^[^\n]*") or ""
	if first == "" then
		return
	end
	if first ~= text then
		vim.notify("Grepping the first line of the selection only", vim.log.levels.WARN)
	end
	require("telescope.builtin").grep_string({ search = first })
end

vim.keymap.set("n", "<leader>fgb", function()
	grep_text(cword())
end, { noremap = true, silent = true, desc = "Telescope grep word under cursor" })

vim.keymap.set("x", "<leader>fgb", function()
	grep_text(vselection())
end, { noremap = true, silent = true, desc = "Telescope grep visual selection" })

map("n", "<leader>c", ":wq<cr>", opts)
map("n", "<leader>w", ":w<cr>", opts)
map("n", "<leader>W", ":Bdelete<cr>:w<cr>", opts)
map("n", "<leader>v", ":vsplit<cr>", opts)
map("n", "<leader>V", ":split<cr>", opts)
map("n", "<leader>F", ":lua require('conform').format() <cr>", opts)
map("n", "<leader>L", ":lua _LAZYGIT_TOGGLE()<cr>", opts) -- requires to be in git repo
map("n", "<leader>E", ":lua _RANGER_TOGGLE()<cr>", opts) -- requires ranger to be installed (big terminal file mngr)
map("n", "<leader>T", ":ToggleTerm direction=horizontal size=20<cr>", opts)
map("n", "<leader>t", ":ToggleTerm direction=float<cr>", opts)
map("n", "<leader>s", ":lua vim.lsp.buf.code_action()<cr>", opts)

-- auto run options
map("n", "<leader>r", ":w<cr>:make<cr>", opts)
map("n", "<leader>R", ":set makeprg=python3\\ ", opts)

-- move to end or front of line in visual and insert mode
map("n", "<leader>g", "0", opts)
map("n", "<leader>h", "$", opts)

map("v", "<leader>g", "0", opts)
map("v", "<leader>g", "0", opts)

map("x", "<leader>h", "$", opts)
map("x", "<leader>h", "$", opts)

map("n", "<leader>o", "o<Esc>", opts)
map("n", "<leader>O", "O<Esc>", opts)

-- Toggle between mouse modes
map("n", "<leader>a", ":set mouse=a<cr>", opts)
map("n", "<leader>A", ":set mouse=r<cr>", opts)

-- Lazy typing binds
map("i", "<A-f>", "=", opts)
