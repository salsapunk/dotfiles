return {
    "akinsho/toggleterm.nvim",

    config = function()
	require('toggleterm').setup({
	    size = 85,
	    open_mapping = [[<C-t>]],
	    direction = 'float',
	    float_opts =  {
		border = 'single'
	    },
	})
    end,
}
