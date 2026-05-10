return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- Base dark theme to modify
			custom_highlights = function()
				return {
					-- Background and UI elements
					Normal = { fg = "#ff6996", bg = "#20000f" },
					NormalFloat = { bg = "#0B000D" },
					NormalNC = { bg = "#09000A" },
					LineNr = { fg = "#ff6996" },
					CursorLineNr = { fg = "#00FFFF", bold = true },
					TreesitterContext = { bg = "#20000f" },
					TreesitterContextLineNumber = { bg = "#20000f", fg = "#00FFFF" },
					StatusLine = { bg = "#3f001e", fg = "#FFDDDD" },
					StatusLineNC = { bg = "#3f001e", fg = "#CCAAAA" },
					TabLine = { bg = "#3f001e" },
					TabLineSel = { bg = "#3f001e", bold = true },

					-- Telescope colors
					TelescopePreviewBorder = { fg = "#ff6996" },
					TelescopeResultsBorder = { fg = "#ff6996" },
					TelescopePromptBorder = { fg = "#ff6996" },
					TelescopePromptTitle = { fg = "#ff6996" },
					TelescopeResultsTitle = { fg = "#ff6996" },
					TelescopePreviewTitle = { fg = "#ff6996" },
					TelescopePromptPrefix = { fg = "#ff6996" },
					TelescopePromptCounter = { fg = "#ff6996" },
					TelescopeMatching = { fg = "#420069" },
					TelescopeSelection = { bg = "None" },

					-- Notify colors
					NotifyERRORBorder = { fg = "#ff6996" },
					NotifyERRORBody = { fg = "#ff6996" },
					NotifyERRORTitle = { fg = "#ff6996" },
					NotifyERRORIcon = { fg = "#ff6996" },
					NotifyWARNBorder = { fg = "#FFEA00" },
					NotifyWARNBody = { fg = "#FFEA00" },
					NotifyWARNTitle = { fg = "#FFEA00" },
					NotifyWARNIcon = { fg = "#FFEA00" },
					NotifyINFOBorder = { fg = "#00ffd3" },
					NotifyINFOBody = { fg = "#00ffd3" },
					NotifyINFOTitle = { fg = "#00ffd3" },
					NotifyINFOIcon = { fg = "#00ffd3" },
					NotifyDEBUGBorder = { fg = "#FFFFFF" },
					NotifyDEBUGBody = { fg = "#FFFFFF" },
					NotifyDEBUGTitle = { fg = "#FFFFFF" },
					NotifyDEBUGIcon = { fg = "#FFFFFF" },
					NotifyLogTime = { fg = "#ff6996" },
					--["@markup.strong"] = { fg = "#ffffff" },
					--["@markup.heading.1.markdown"] = { fg = "#ffffff" },

					-- Syntax elements
					Comment = { fg = "#a000ff", italic = true },
					Keyword = { fg = "#ff6996" },
					Function = { fg = "#a000ff", bold = true },
					Type = { fg = "#8BE9FD" },
					String = { fg = "#00FFAC" },
					Number = { fg = "#FF0000" },
					Constant = { fg = "#BD93F9" },
					Special = { link = "@Keyword" },
					Identifier = { fg = "#a000ff" },
					PreProc = { fg = "#a000ff" },
					-- Links
					RustCommentLine = { link = "@comment" },

					-- Treesitter
					["@variable"] = { fg = "#FFEA00" },
					["@parameter"] = { fg = "#00DEFF" },
					["@function"] = { fg = "#FFEA00", bold = true },
					["@method"] = { fg = "#FFB2EF", bold = true },
					["@keyword"] = { fg = "#ff6996", italic = false },
					["@property"] = { fg = "#D42055" },
					["@field"] = { fg = "#FFEA00" },
					["@type"] = { fg = "#8BE9FD" },
					["@operator"] = { fg = "#ff6996" },
					["@comment"] = { fg = "#a000ff", italic = true },
					["@macro"] = { fg = "#FF1100" },
					["@type.builtin"] = { fg = "#A100FF", bold = true },
					-- Links
					["@lsp.typemod.macro.defaultLibrary.rust"] = { link = "@macro" },
					["@lsp.type.variable"] = { link = "@variable" },
					["@lsp.type.comment.rust"] = { link = "Comment" },
					["@lsp.type.macro.rust"] = { link = "@macro" },
					["@lsp.typemod.function.macro.rust"] = { link = "@function.macro" },
				}
			end,
			integrations = {
				cmp = true,
				treesitter = true,
				telescope = true,
				mason = true,
				which_key = true,
				lsp_trouble = true,
			},
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
