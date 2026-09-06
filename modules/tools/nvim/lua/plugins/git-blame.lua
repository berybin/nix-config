-- https://github.com/f-person/git-blame.nvim
return {
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = "  <summary> • <author> • <date> ",
			date_format = "%r",
			display_virtual_text = 0,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local git_blame = require("gitblame")

			table.insert(opts.sections.lualine_x, 1, {
				git_blame.get_current_blame_text,
				cond = git_blame.is_blame_text_available,
				draw_empty = false,
			})
		end,
	},
}
