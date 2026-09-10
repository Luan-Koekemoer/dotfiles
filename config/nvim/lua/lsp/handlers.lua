local M = {}

-- TODO: backfill this to template
M.setup = function()
    local config = {
        virtual_text = true,
        -- show signs
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = '',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.HINT] = '',
                [vim.diagnostic.severity.INFO] = '',
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            },
            numhl = {
                [vim.diagnostic.severity.WARN] = 'WarningMsg',
            },
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = true,
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.o.winborder = "rounded"
end

local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

local function lsp_highlight_document(client, bufnr)
    if not client:supports_method("textDocument/documentHighlight") then
        return
    end

    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", {
        group = highlight_augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = highlight_augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

local function lsp_keymaps(bufnr)
    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
    end

    map("gD", vim.lsp.buf.declaration, "declaration")
    map("gd", vim.lsp.buf.definition, "definition")
    map("gi", vim.lsp.buf.implementation, "implementation")
    map("gr", vim.lsp.buf.references, "references")
    map("<leader>rn", vim.lsp.buf.rename, "rename")
    map("<leader>ca", vim.lsp.buf.code_action, "code action")

    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "hover")
    map("<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "signature help")

    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "prev diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "next diagnostic")
    map("gl", vim.diagnostic.open_float, "show diagnostic")
    map("<leader>q", vim.diagnostic.setloclist, "diagnostics to loclist")

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer via LSP" })
end

M.on_attach = function(client, bufnr)
    if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

M.capabilities = capabilities

return M
