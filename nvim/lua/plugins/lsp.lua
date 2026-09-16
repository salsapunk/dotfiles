-- lua/plugins/lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
			},
		})

		vim.lsp.config("eslint", {
			settings = {
				workingDirectories = { mode = "auto" },
			},
		})

		vim.lsp.config("tailwindcss", {
			filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buff }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
