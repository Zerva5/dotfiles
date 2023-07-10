local default_lsp_map = function(client, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- List all symbols in document
	--vim.keymap.set('n', '<leader>lp', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', vim.lsp.buf.document_symbol, opts)

	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', vim.lsp.buf.declaration, opts)
	--
	vim.keymap.set('n', '<leader>fd', vim.lsp.buf.format, opts)
end



------ LSP
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- Pythoin LSP
lspconfig.pyright.setup { on_attach = default_lsp_map,
}

-- Lua LSp
lspconfig.lua_ls.setup { on_attach = default_lsp_map,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

lspconfig.ccls.setup {
	init_options = {
		compilationDatabaseDirectory = "build",
		index = {
			threads = 0,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	}
}
