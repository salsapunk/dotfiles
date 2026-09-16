require("config.lazy")
require("config.keymaps")
require("config.options")

vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')

-- adiciona o path do .cargo (treesitter cli) no path do nvim
vim.env.PATH = vim.env.HOME .. '/.cargo/bin:' .. '/go/bin' .. '/bin/eslint' .. vim.env.PATH

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	once = true,
	callback = function()
		require("config.lsp")
	end,
})

vim.lsp.enable("gopls")

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldenable = false
