-- line wrap
vim.wo.wrap = false
-- line numbers
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Undo file
vim.o.undofile = true

-- Search case insesitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- Always on sign column
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Better completition
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = false


-- NETRW stuff
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
