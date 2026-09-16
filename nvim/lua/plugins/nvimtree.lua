return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
	vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>')

	require('nvim-tree').setup({
	    view = {
		width = 25,
	    },
	     renderer = {
		group_empty = true,
		icons = {
		    show = {
			git = true,
			folder = true,
			file = true,
			folder_arrow = true,
		    },
		},
	    },
	    filters = {
		dotfiles = true,
	    },
	})
    end
}
