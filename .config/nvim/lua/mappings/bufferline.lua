-- cycle between tabs and buffers
-- bufferline will determine it for us, auto matically
vim.keymap.set("n", "eh", ":BufferLineCyclePrev<cr>")
vim.keymap.set("n", "el", ":BufferLineCycleNext<cr>")

-- this moves a buffer back and forth
vim.keymap.set("n", "fh", ":BufferLineMovePrev<cr>")
vim.keymap.set("n", "fl", ":BufferLineMoveNext<cr>")
