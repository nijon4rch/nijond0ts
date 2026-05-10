-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setting options
--Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4
-- Expand tabs into spaces
vim.opt.expandtab = false
vim.g.python_recommended_style = 0

vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%l%s"
vim.opt.relativenumber = true
--Save undo history
vim.opt.undofile = true
--Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
--Decrease update time
vim.opt.updatetime = 250
--Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
--Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
--Sets how neovim will display certain whitespace characters in the editor.
vim.g.have_nerd_font = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
--Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- open all folds by default
vim.opt.laststatus = 0 -- Never show the status line
vim.opt.showmode = false -- Hide mode indicators (e.g., "-- INSERT --")
vim.opt.ruler = false -- Hide cursor position info
vim.opt.cmdheight = 0
vim.g.screenkey_statusline_component = true
vim.cmd("language en_US.UTF-8")

-- Sync OS and Nvim clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.autoread = true

-- Keymaps
vim.keymap.set("i", "<C-c>", "<Esc>", options)
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set({ "n", "v" }, "D", '"_d')
--vim.keymap.set({ "n", "x" }, "s", "<Nop>")
--Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", ",", "<Plug>(leap-anywhere)")
vim.keymap.set({ "x", "o" }, ",", "<Plug>(leap)")

-- Theming
vim.opt.termguicolors = true -- Enable true color support
vim.opt.syntax = "on" -- Enable syntax highlighting
vim.opt.background = "dark" -- Use dark background for better reds
vim.api.nvim_command("highlight fidgetDone guifg=#00FFAC gui=bold")
vim.api.nvim_command("highlight fidgetProgress guifg=#00F gui=bold")
vim.api.nvim_command("highlight fidgetGroup guifg=#FF1100 gui=bold")
vim.api.nvim_command("highlight fidgetIcon guifg=#FFEA00 gui=bold")
vim.api.nvim_command("highlight fidgetGroupSep guifg=#420069 gui=bold")
vim.api.nvim_command("highlight fidgetNormal guifg=#FF0042 gui=bold")
--Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
	dev = {
		-- Directory where you store your local plugin projects. If a function is used,
		-- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
		---@type string | fun(plugin: LazyPlugin): string
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
}, {
	ui = { icons = vim.g.have_nerd_font and {} },
})
