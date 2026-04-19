return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {
			preset = "ghost",
			options = {
				multilines = {
					enabled = true,
					always_show = true,
				},
				add_messages = {
					display_count = true,
				},
				show_source = {
					enabled = true,
				},
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = { diagnostics = { virtual_text = false } },
	},
}
