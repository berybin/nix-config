return {
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				-- Running both: oxlint for the fast stuff, eslint for the deep Vue rules
				vue = { "oxlint", "eslint_d" },
				javascript = { "oxlint", "eslint_d" },
				typescript = { "oxlint", "eslint_d" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "oxfmt" },
				typescript = { "oxfmt" },
				vue = { "oxfmt" },
				css = { "oxfmt" },
			},

			formatters = {
				oxfmt = {
					command = "oxfmt",
					args = { "--stdin-filepath", "$FILENAME" },
					stdin = true,
				},
			},
		},
	},
}
