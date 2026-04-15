return {
	"rbong/vim-flog",
	lazy = true,
	cmd = { "Flog", "Flogsplit", "Floggit" },
	dependencies = {
		"tpope/vim-fugitive",
	},
	keys = {
		{ "<leader>gl", "<CMD>Flog -date=short -all -- --no-show-signature<CR>", desc = "Git Graph (Flog)" },
	},
	init = function()
		vim.g.flog_enable_extended_chars = true
		vim.g.flog_default_opts = { max_count = 2000 }
	end,
}
