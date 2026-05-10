return {
	"NStefan002/screenkey.nvim",
	version = "*", -- or branch = "dev", to use the latest commit
	config = function()
		require("screenkey").setup({
			win_opts = {
				row = 1,
				anchor = "NE",
				height = 1,
				title = "",
			},
		})
	end,
}
