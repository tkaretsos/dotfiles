-- OPTIONS
vim.opt.laststatus = 2
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true

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
