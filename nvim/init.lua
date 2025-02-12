vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- tab stuff
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.showtabline = 0
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

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

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		--- LSP ---
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		--- FORMATTER ---
		"stevearc/conform.nvim",
		--- MINI ---
		{ "echasnovski/mini.nvim", version = "*" },
	},
	install = {
		missing = true,
		colorscheme = { "minischeme" },
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.cmd("colorscheme minischeme")

--- LSP CONFIG ---
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "ts_ls" } })

--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			format = { enable = true },
		},
	},
})

lspconfig.ts_ls.setup({})

--- FORMATTER ---

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)

--- MINI ---

require("mini.comment").setup() --gcc

require("mini.completion").setup({
	window = {
		info = { height = 25, width = 80, border = "rounded" },
		signature = { height = 25, width = 80, border = "rounded" },
	},
}) -- ctrl + space  / ctrl + n / ctrl + p / ctrl + e

require("mini.move").setup() -- alt + hjkl

require("mini.pairs").setup()

require("mini.surround").setup()
-- Add surrounding with sa (in visual mode or on motion).
-- Delete surrounding with sd.
-- Replace surrounding with sr.
-- Find surrounding with sf or sF (move cursor right or left).
-- Highlight surrounding with sh.
-- Change number of neighbor lines with sn (see :h MiniSurround-algorithm).

require("mini.diff").setup({ view = { style = "sign" } })

vim.keymap.set("n", "<leader>d", function()
	require("mini.diff").toggle_overlay()
end)

-- visual mode gH reset hunk
