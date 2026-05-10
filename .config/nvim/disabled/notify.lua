return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#0b000d",
		})
		vim.notify = require("notify")
	end,
}
