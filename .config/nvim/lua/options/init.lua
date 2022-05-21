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
set.mouse = "a"

-- set colour scheme
set.termguicolors = true
-- dont' halt the executino when it produces an error
pcall(function()
  vim.cmd "colorscheme catppuccin"
end)

-- set leader keys
vim.g.leader = "-"
vim.g.localleader = "\\"

-- vimwiki
vim.g.vimwiki_list = {
  { path = "~/Documents/vimwiki", syntax = "markdown", ext = ".md" },
}
