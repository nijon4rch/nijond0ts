return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		ft = { "rust" },
		config = function()
			-- rustaceanvim configuration
			vim.g.rustaceanvim = {
				-- Plugin settings
				tools = {
					-- Enable inlay hints
					inlay_hints = {
						auto = true,
						only_current_line = false,
						show_parameter_hints = true,
					},
					-- Configure hover actions menu
					hover_actions = {
						auto_focus = true,
					},
				},
				-- LSP settings
				server = {
					on_attach = function(client, bufnr)
						-- Keymaps and setup here
						local map = function(mode, lhs, rhs, desc)
							vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
						end

						-- Hover documentation
						map("n", "<leader>rK", "<cmd>RustLsp hover actions<CR>", "[R]ust Hover Actions")
						-- Code actions
						map("n", "<leader>rca", "<cmd>RustLsp codeAction<CR>", "[R]ust [C]ode [A]ction")
						-- Run the current file
						map("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", "[R]ust [R]unnables")
						-- Expand macros
						map("n", "<leader>rm", "<cmd>RustLsp expandMacro<CR>", "[R]ust Expand [M]acro")
						-- Open Cargo.toml
						map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", "Open [C]argo.toml")
						-- View crate documentation
						map("n", "<leader>rd", "<cmd>RustLsp externalDocs<CR>", "[R]ust External [D]ocs")
						-- Reborrow check
						map("n", "<leader>rb", "<cmd>RustLsp rebuildProcMacros<CR>", "Re[B]uild Proc Macros")
						-- Standard key mappings
						map("n", "<leader>rgd", "<cmd>RustLsp hover actions<CR>", "[R]ust [G]oto [D]efinition")
						map("n", "<leader>rn", "<cmd>RustLsp rename<CR>", "[R]ust Re[N]ame")
						vim.schedule(function()
							vim.cmd([[
								highlight! link @lsp.type.comment.rust Comment
								highlight! link @lsp.type.macro.rust @macro
								highlight! link @lsp.typemod.function.macro.rust @function.macro
							]])
						end)
					end,

					settings = {
						-- rust-analyzer settings
						["rust-analyzer"] = {
							-- Enable clippy on save
							checkOnSave = true,

							check = {
								command = "clippy",
								allFeatures = true,
							},
							-- Enable experimental features
							procMacro = {
								enable = true,
							},
							-- Inlay hints
							inlayHints = {
								bindingModeHints = { enable = true },
								closureReturnTypeHints = { enable = "always" },
								expressionAdjustmentHints = { enable = "always" },
								lifetimeElisionHints = { enable = "always", useParameterNames = true },
							},
							-- Cargo settings
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
						},
					},
				},
			}
		end,
	},
}
