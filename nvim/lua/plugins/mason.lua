return {
	{
		"mason-org/mason.nvim",
		config = function()
			require('mason').setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					},
				},
			})
		end,
		opts = {
			ensure_installed = {
				"clangd",
				"goimports",
				"gofumpt",
				"gomodifytags",
				"impl",
				"golangci-lint",
				"delve",
				"markdownlint-cli2",
				"markdown-toc",
			},
		}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"pyright",
					"ts_ls",
					"eslint",
					"gopls",
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",
				},
				automatic_installation = true,
				automatic_enable = true,
			})
		end,
	},
}
