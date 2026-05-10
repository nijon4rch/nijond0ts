return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local devicons = require("nvim-web-devicons")
		require("lualine").setup({
			options = {
				component_separators = "",
				section_separators = { left = "", right = "" },
				globalstatus = true,
				theme = {
					normal = {
						a = { bg = "#FF6B6B", fg = "#5C0000" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
					insert = {
						a = { bg = "#98C379", fg = "#2C4C1F" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
					visual = {
						a = { bg = "#C678DD", fg = "#4D2A5C" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
					replace = {
						a = { bg = "#E06C75", fg = "#5C1C21" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
					command = {
						a = { bg = "#E5C07B", fg = "#5C4B1B" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
					inactive = {
						a = { bg = "#19090f" },
						b = { bg = "#19090f" },
						c = { bg = "#19090f" },
						x = { bg = "#19090f" },
						y = { bg = "#19090f" },
						z = { bg = "#19090f" },
					},
				},
			},
			sections = {
				-- Left bubble-style mode indicator
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return "  " .. str .. " "
						end,
						separator = { left = "", right = "" },
						padding = 0,
					},
				},

				-- Git info + language logo + filename
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { bg = "#19090f", fg = "#FF8888" },
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						color = { bg = "#19090f", fg = "#FFAAAA" },
					},
					{
						function()
							local ft = vim.bo.filetype
							-- Use nvim-web-devicons to get the icon
							local icon, color =
								devicons.get_icon_color(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })

							-- If no icon is found, fallback to uppercase filetype
							if not icon or icon == "" then
								return ft:upper()
							end

							-- Return the icon with custom color
							return icon
						end,
						color = { bg = "#19090f", fg = "#FF7777" },
					},
					{
						"filename",
						path = 1,
						color = { bg = "#19090f", fg = "#FF9999" },
					},
				},

				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󰠠 " },
						colored = true,
						color = { bg = "#19090f" },
					},
				},

				lualine_x = {
					{
						function()
							return require("screenkey").get_keys()
						end,
						-- LSP server name
						function()
							local clients = vim.lsp.get_clients()
							if next(clients) == nil then
								return "No LSP"
							end

							local client_names = {}
							for _, client in ipairs(clients) do
								-- Check if the client is attached to the current buffer
								local bufnr = vim.api.nvim_get_current_buf()
								local is_attached = false
								for _, buf_id in ipairs(vim.lsp.get_buffers_by_client_id(client.id)) do
									if bufnr == buf_id then
										is_attached = true
										break
									end
								end

								if is_attached then
									table.insert(client_names, client.name)
								end
							end

							return " " .. table.concat(client_names, ", ")
						end,
						color = { bg = "#19090f", fg = "#FF0042" },
						sepatator = { left = "", right = "" },
					},
				},

				lualine_y = {
					{
						"location",
						color = { bg = "#19090f", fg = "FF9999" },
					},
					{
						"progress",
						fmt = function(str)
							return str .. " "
						end,
						color = { bg = "#19090f", fg = "#FF9999" },
						padding = 0,
					},
				},

				lualine_z = {
					{
						"encoding",
						fmt = function(str)
							return ": " .. str
						end,
						color = { bg = "#19090f", fg = "#FF8888" },
					},
					{
						"fileformat",
						symbols = {
							unix = "I use arch btw ",
							dos = "I use arch btw ",
							mac = "I use arch btw ",
						},
						color = { bg = "#19090f", fg = "#FF7777" },
					},
				},
			},
		})
	end,
}
