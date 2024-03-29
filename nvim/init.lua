-- OPTIONS
vim.opt.laststatus = 2
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- show leading whitespace
vim.opt.list = true
vim.opt.listchars = "tab:→ ,trail:·"

-- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#concealing-characters
vim.opt.conceallevel = 1

-- delete trailing spaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- automatically clear search highlighting
vim.cmd('set nohlsearch')

-- KEYMAPS
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("plugins")
