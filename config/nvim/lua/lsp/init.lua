local handlers = require("lsp.handlers")

require("lsp.mason")
handlers.setup()
require("lsp.formatter")
require("lsp.lsp-signature")
require("lsp.dap")
require("lsp.treesitter")

vim.lsp.config("*", {
    capabilities = handlers.capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_handlers", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            handlers.on_attach(client, args.buf)
        end
    end,
})

-- Define configs (native API)
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git', '.luarc.json', '.luarc.jsonc', 'stylua.toml' },
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})

-- Without an interpreter pyright resolves no third-party import, so every
-- `django.*` line is an error and gd into a dependency finds nothing. Only cheap
-- lookups here -- `pipenv --venv` is the authority but takes ~4s, too slow to
-- block the client on.
local function python_path(root)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end

  local candidates = { root .. '/.venv/bin/python', root .. '/venv/bin/python' }

  -- pipenv parks venvs outside the project as <basename>-<hash-of-path>.
  local pipenv = vim.fn.glob(vim.fn.expand('~/.local/share/virtualenvs/') ..
    vim.fn.fnamemodify(root, ':t') .. '-*/bin/python', true, true)
  if #pipenv == 1 then
    table.insert(candidates, pipenv[1])
  end

  for _, path in ipairs(candidates) do
    if vim.uv.fs_stat(path) then
      return path
    end
  end
  return nil
end

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  -- Prevent <default workspace root> issues:
  root_markers = { '.git', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'manage.py' },
  -- (Optional) if you often open single files outside a project:
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { '.git', 'pyproject.toml', 'setup.py', 'manage.py' })
    on_dir(root or vim.fn.getcwd())
  end,
  before_init = function(_, config)
    local python = python_path(config.root_dir)
    if python then
      config.settings.python.pythonPath = python
    end
  end,
  settings = {
    python = {
      analysis = { typeCheckingMode = 'off' },
    },
  },
})

vim.lsp.config('djlsp', {
  cmd = { 'djlsp' }, -- or absolute path
  filetypes = { 'htmldjango' }, -- adjust if your ft differs
  root_markers = { '.git', 'manage.py', 'pyproject.toml' },
  init_options = {
    -- For django-template-lsp 0.8.0:
    djlsp = {
      -- strongly recommended to set this:
      django_settings_module = 'your_project.settings',
      docker_compose_file = 'docker-compose.yml',
      docker_compose_service = 'django',
    },
  },
})

-- Enable auto-start
vim.lsp.enable({ 'lua_ls', 'pyright', 'djlsp' })
