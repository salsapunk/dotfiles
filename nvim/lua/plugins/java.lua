return {
	'nvim-java/nvim-java',
	config = function()
		require('java').setup({
			jdtls = { enable = true, auto_install = true },
			spring_boot_tools = { enable = true, auto_install = true },
			java_test = { enable = true, auto_install = true },
			java_debug_adapter = { enable = true, auto_install = true },
		})
	end,
}
