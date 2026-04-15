-- https://github.com/f-person/git-blame.nvim
return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,
		message_template = "  <summary> • <author> • <date> ",
		date_format = "%r",
	},
}
