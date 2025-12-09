vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.textwidth=80
vim.o.formatoptions = "atw"

-- vim.opt.linebreak = true
-- vim.opt.breakindent = true
-- vim.opt.breakindentopt = "shift:2"

local keymapping = vim.api.nvim_buf_set_keymap

keymapping(0, "n", "<leader>ni", ":Neorg inject-metadata<CR>", {noremap = true})
keymapping(0, "n", "<leader>nw", ":Neorg workspace<CR>", {noremap = true})
keymapping(0, "n", "<leader>nt", ":Neorg toggle-concealer<CR>", {noremap = true})

-- keymapping(0, "n", "j", "gj", {noremap = true})
-- keymapping(0, "n", "k", "gk", {noremap = true})
-- keymapping(0, "n", "0", "g0", {noremap = true})
-- keymapping(0, "n", "$", "g$", {noremap = true})

-- indenting
keymapping(0, "n", "<leader>lf", "gg=G<C-o>", {noremap = true})
