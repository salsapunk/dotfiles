return {
    {	-- helps with ssh tunneling and copying to clipboard
	"ojroques/vim-oscyank",	
    },
    {	-- git plugin
	"tpope/vim-fugitive",
    },
    {
	"brenoprata10/nvim-highlight-colors",
	config = function()
	    require("nvim-highlight-colors").setup({})
	end
    },
    {
	"barrettruth/live-server.nvim",
    },
    {
      "fredrikaverpil/neotest-golang",
    },
    {
    "leoluz/nvim-dap-go", opts = {},
    },
    {
	"mattn/emmet-vim",
    },
    {
	"windwp/nvim-ts-autotag",
	config = function()
	    require('nvim-ts-autotag').setup({})
	end
    },
}
