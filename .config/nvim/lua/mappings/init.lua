vim.g.mapleader = "-"
vim.g.localleader = "\\"

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("n", "<M-h>", "<c-w>h")
vim.keymap.set("n", "<M-j>", "<c-w>j")
vim.keymap.set("n", "<M-k>", "<c-w>k")
vim.keymap.set("n", "<M-l>", "<c-w>l")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sv", "so $MYVIMRC<cr>")

require "mappings/bufferline"
require "mappings/telescope"
require "mappings/lspconfig"
require "mappings/nvim-tree"
