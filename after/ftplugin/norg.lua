vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"

vim.keymap.set("n", "<leader>ni", ":Neorg inject-metadata<CR>")
vim.keymap.set("n", "<leader>nw", ":Neorg workspace<CR>")
vim.keymap.set("n", "<leader>nt", ":Neorg toggle-concealer<CR>")

function Surround(char)
	vim.cmd("normal! i" .. char .. string.char(27) .. "`>a" .. char .. string.char(27))
end

vim.keymap.set("v", "<leader>nb", function()
	Surround("*")
end)
