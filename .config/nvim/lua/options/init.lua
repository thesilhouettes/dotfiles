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

-- no virtual text diagnostics
vim.diagnostic.config {
  virtual_text = false,
}

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

-- vimtex
vim.g.vimtex_quickfix_open_on_warning = 0

-- stolen from https://ejmastnak.github.io/tutorials/vim-latex/compilation.html
-- Filter out some compilation warning messages from QuickFix display
vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull \\hbox",
  "Overfull \\hbox",
  "LaTeX Warning: .\\+ float specifier changed to",
  "LaTeX hooks Warning",
  'Package siunitx Warning: Detected the "physics" package:',
  "Package hyperref Warning: Token not allowed in a PDF string",
}

-- ultisnips
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
vim.g.UltiSnipsSnippetDirectories = {
  os.getenv "HOME" .. "/.config/nvim/ultisnips",
}
