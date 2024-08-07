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
    local r, c = vim.api.nvim_win_get_cursor(0)
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
map("n", "<leader>d", ":Bdelete<cr>", opts)
map("n", "<leader>b", ":TagbarToggle<cr>", opts)

--Telescope
map(
    "n",
    "<leader>ff",
    ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
    opts
)
map("n", "<leader>fp", ":lua require('telescope.builtin').find_files(require('telescope.themes'))<cr>", opts)
map(
    "n",
    "<leader>fb",
    ":lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
    opts
)
map("n", "<leader>fc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", opts) -- requires git-worktree extention
map("n", "<leader>fw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", opts)       -- requires git-worktree extention

map("n", "<leader>c", ":wq<cr>", opts)
map("n", "<leader>w", ":w<cr>", opts)
map("n", "<leader>W", ":Bdelete<cr>:w<cr>", opts)
map("n", "<leader>v", ":vsplit<cr>", opts)
map("n", "<leader>V", ":split<cr>", opts)
map("n", "<leader>F", ":lua vim.lsp.buf.format()<cr>", opts)
map("n", "<leader>L", ":lua _LAZYGIT_TOGGLE()<cr>", opts) -- requires to be in git repo
map("n", "<leader>E", ":lua _RANGER_TOGGLE()<cr>", opts)  -- requires ranger to be installed (big terminal file mngr)
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
