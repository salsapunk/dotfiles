return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},

	config = function()
		local telescope = require("telescope")
		local actions   = require("telescope.actions")

		local builtin   = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


		telescope.setup({
			defaults = {
				border           = true,
				prompt_prefix    = "   ",
				selection_caret  = " ▌ ",
				entry_prefix     = "   ",
				multi_icon       = " + ",
				sorting_strategy = "ascending",
				layout_strategy  = "horizontal",
				layout_config    = {
					prompt_position = "top",
					preview_width   = 0.55,
					width           = 0.87,
					height          = 0.80,
				},
			},
			pickers = {
				find_files = { hidden = true },
				live_grep  = { additional_args = { "--hidden" } },
			},
		})
	end,
}
