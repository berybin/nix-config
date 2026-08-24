return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "vue", "css" } },
	},

	-- Add LSP servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vue_ls = {},
				vtsls = {},
			},
		},
	},
	-- Configure tsserver plugin
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			table.insert(opts.servers.vtsls.filetypes, "vue")

			-- resolve path for vue_ls so we don't need to manually update a nix store path
			local bin_path = vim.fn.exepath("vue-language-server")
			local real_path = vim.fn.resolve(bin_path)
			local base_dir = vim.fn.fnamemodify(real_path, ":h:h")
			local vue_ls_path = base_dir .. "/lib/language-tools/packages/language-server"

			LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
				{
					name = "@vue/typescript-plugin",
					location = vue_ls_path,
					languages = { "vue" },
					configNamespace = "typescript",
					enableForWorkspaceTypeScriptVersions = true,
				},
			})
		end,
	},
}
