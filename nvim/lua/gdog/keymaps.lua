Keymaps = {}

Keymaps.setup = function()
-- kill space in normal and visual mode

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>e', vim.cmd.Exp)
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- TELESCOPE SEARCH--

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
end

-- LSP --
Keymaps.lsp_on_attach = function(_, bufnr)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]e[n]ame' })
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })
	vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
		{ buffer = bufnr, desc = '[G]oto [D]efinition' })
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
		{ buffer = bufnr, desc = '[G]oto [R]eferences' })
	vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
		{ buffer = bufnr, desc = '[G]oto [I]mplementation' })
	vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions,
		{ buffer = bufnr, desc = 'Type [D]efinition' })
	vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
		{ buffer = bufnr, desc = '[D]ocument [S]ymbols' })
	vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = '[W]orkspace [S]ymbols' })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
	-- Add format command :Format
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

return Keymaps
