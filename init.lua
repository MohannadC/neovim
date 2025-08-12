--- Apart from this cfg I fixed "Undefined global vim" issue in nvim-lspconfig/lsp/lua_ls.lua
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorcolumn = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.scrolloff = 10
vim.o.list = true
vim.o.cursorline = true
vim.o.listchars = "tab:⁞ ,trail:·,nbsp:␣"
vim.g.mapleader = " "
vim.g.localleader = " "

--- Setting up native nvim langmap (not a plugin)
local function escape(str)
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
	escape(ru_shift) .. ";" .. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

--- Getting and setting up plugins
vim.pack.add({
	{ src = "https://github.com/Wansmer/langmapper.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("langmapper").setup()
require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

--- vim.lsp.enable assumes these executables are somewhere in PATH
--- This means you have to install them through brew or smth
vim.lsp.enable({ "lua_ls", "gopls" })

--- Keymaps
--- Native mapping function
-- local map = vim.keymap.set
--- Mapping function from the plugin
local map = require("langmapper").map
local MiniPick = require("mini.pick")
map("i", "jk", "<Esc>")
map("n", "<leader>pv", vim.cmd.Ex)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map({ "n", "v", "x" }, "<leader>y", '"+y')
map({ "n", "v", "x" }, "<leader>d", '"+d')
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>e", MiniPick.builtin.files)
map("n", "<leader>g", MiniPick.builtin.grep_live)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>q", vim.diagnostic.setloclist)
map("n", "<leader>l", vim.cmd.nohlsearch)
map("n", "gl", vim.diagnostic.open_float)
map("n", "gd", vim.lsp.buf.definition)

--- Autocompletion. Without it press <C-x><C-o> for suggestions
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("my.lsp", {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

--- Creating new highlight group
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("Color", {}),
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "HighlightYank", { bg = "#1E4F69" })
	end
})

--- Highlight on yank with newly created highlight group
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.hl.on_yank({ higroup = "HighlightYank" }) end
})

--- Disabling autoselection in suggestions, settign a colorscheme and making statusline transparent
vim.cmd("set completeopt+=noselect")
vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")

--- Translating all global keymaps from nvim
require("langmapper").automapping({ global = true, buffer = false })
