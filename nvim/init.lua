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
		--- AUTO TAG ---
		"windwp/nvim-ts-autotag",
		--- MINI ---
		{ "echasnovski/mini.nvim", version = "*" },
		--- TELESCOPE ---
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			-- or                              , branch = '0.1.x',
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},
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
require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "eslint", "cssls" } })

--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "lang" } },
			format = { enable = true },
		},
	},
})

lspconfig.ts_ls.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.eslint.setup({})
lspconfig.cssls.setup({})
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

--- AUTO TAG ---
require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
})
--- MINI ---

require("mini.comment").setup() --gcc

require("mini.completion").setup({
	window = {
		info = { height = 25, width = 80, border = "rounded" },
		signature = { height = 25, width = 80, border = "rounded" },
	},
}) -- ctrl + space  / ctrl + n / ctrl + p / ctrl + e

require("mini.move").setup() -- alt + hjkl

require("mini.icons").setup()

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

require("mini.statusline").setup()

require("mini.tabline").setup()

require("mini.notify").setup()
--- TELESCOPE ---

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })

--- Treesitter ---

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"html",
		"javascript",
		"json",
		"typescript",
		"css",
		"tsx",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,
})
