---@type vim.lsp.Config
return {
	root_dir = require("lspconfig").util.root_pattern(
		"docker-compose.yaml",
		"docker-compose.yml",
		"compose.yaml",
		"compose.yml"
	),
}
