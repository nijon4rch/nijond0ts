return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath("data") .. "/site",

			-- Languages to install parsers for
			ensure_installed = {
				"rust", -- Add more languages as needed
			},

			-- Install parsers synchronously (only for ensure_installed)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- Enable syntax highlighting
			highlight = {
				enable = true,
				-- Disable for specific languages if needed
				-- disable = { "c", "rust" },
			},

			-- Enable indentation based on treesitter
			indent = {
				enable = true,
			},

			matchup = {
				enable = true,
			},

			-- Enable incremental selection (select expanding code nodes)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- Start selection
					node_incremental = "grn", -- Expand selection
					scope_incremental = "grc", -- Expand to scope
					node_decremental = "grm", -- Shrink selection
				},
			},
		})
	end,
}
