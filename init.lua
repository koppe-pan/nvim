vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.clipboard = ""
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmode = "longest:full,full"

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
vim.opt.completeopt = "menu,menuone,noselect"

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "s", '"_s', { noremap = true })
vim.keymap.set("n", "<Leader>h", "^", { noremap = true })
vim.keymap.set("n", "<Leader>l", "$", { noremap = true })
vim.keymap.set("v", "<Leader>h", "^", { noremap = true })
vim.keymap.set("v", "<Leader>l", "$", { noremap = true })
--vim.keymap.set("n", "<Leader>w", ":w<CR>")
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>")

vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("v", "j", "gj", { noremap = true })
vim.keymap.set("v", "k", "gk", { noremap = true })

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

local function float_term(cmd)
	local opts = { size = { width = 0.9, height = 0.9 } }
	require("lazy.util").float_term(cmd, opts)
end
vim.keymap.set("n", "<Leader>gg", function()
	float_term({ "lazygit" })
end)

-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- window
vim.keymap.set("n", "<leader>ww", "<C-w>p", { desc = "Other window" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
vim.keymap.set("n", "<leader>w-", "<C-w>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w|", "<C-w>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

--local lazypath = "@lazy_nvim@"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	defaults = { lazy = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	spec = "plugins",
})

require("misc")
