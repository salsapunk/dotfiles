return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
	{ "windwp/nvim-ts-autotag" },
    },
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    
    config = function()
	require("nvim-treesitter").setup({})

	require("nvim-treesitter").install({
	    'c', 'cpp', 'sql',
	    'go', 'gosum', 'gomod', 'gowork', 'gotmpl',
	    'comment',
	    'tsx', 'javascript', 'typescript',
	    'html', 'css', 'json',
	    'lua', 'markdown', 'vim', 'vimdoc',
	})

	vim.api.nvim_create_autocmd("FileType", {
	    pattern = {
		'c', 'cpp', 'sql',
		'go', 'gosum', 'gomod', 'gowork', 'gotmpl',
		'comment',
		'tsx', 'javascript', 'typescript',
		'html', 'css', 'json',
		'lua', 'markdown', 'vim', 'vimdoc',
	    },
	    callback = function()
		pcall(vim.treesitter.start)
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	    end,
	})
    end,
}
