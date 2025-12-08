vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = true

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"

vim.keymap.set("n", "<leader>ni", ":Neorg inject-metadata<CR>")
vim.keymap.set("n", "<leader>nw", ":Neorg workspace<CR>")
vim.keymap.set("n", "<leader>nt", ":Neorg toggle-concealer<CR>")

-- indenting
vim.api.nvim_buf_set_keymap(0, "n", "<leader>lf", "gg=G<C-i>", {noremap = true})
