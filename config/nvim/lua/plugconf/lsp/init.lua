local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugconf.lsp.lsp-installer")
require("plugconf.lsp.handlers").setup()
require("plugconf.lsp.null-ls")
