local set = vim.opt
set.number = true
set.numberwidth = 4
set.compatible = false
set.encoding = "UTF8"
set.laststatus = 2
set.showmode = false
set.hidden = true
set.linespace = 2
set.autoindent = true
set.textwidth = 80
set.shiftwidth = 2
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.splitbelow = true
set.splitright = true
set.signcolumn = "yes"

-- set colour scheme
set.termguicolors = true
vim.cmd "colorscheme catppuccin"

-- set leader keys
vim.g.leader = "-"
vim.g.localleader = "\\"
