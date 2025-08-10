vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.cursorcolumn = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.g.mapleader = " "

local map = vim.keymap.set
map('i', 'jk', '<Esc>')
map('n', '<leader>pv', ':Explore<CR>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

map('n', '<leader>l', ':noh<CR>')
map('n', '<leader>e', ':Pick files<CR>')
map('n', '<leader>g', ':Pick grep_live<CR>')
map('n', '<leader>f', vim.lsp.buf.format)
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "gd", vim.lsp.buf.definition)

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

--- vim.lsp.enable assumes these executables are somewhere in PATH
--- This means you have to install them through brew or smth
vim.lsp.enable({ 'lua_ls', 'gopls' })

--- This is autocompletion ↓, with it commented press <C-x> <C-o> for suggestions
--- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })
vim.cmd("set completeopt+=noselect")

vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")
--- Also I fixed 'Undefined global vim' issue in nvim-lspconfig/lsp/lua_ls.lua
