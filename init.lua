-- Leader must be set BEFORE any leader keymaps
vim.g.mapleader = " "

-- ============================================================================
-- Settings
-- ============================================================================

vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.completeopt:append({ "menuone", "noselect", "popup" })

vim.cmd("hi @lsp.type.number gui=bold")

-- ============================================================================
-- Plugins
-- ============================================================================

vim.pack.add({
	-- Appearance
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/tiagovla/tokyodark.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- Editing
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	-- Tmux
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/aserowy/tmux.nvim" },

	-- Navigation
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "master" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/LinArcX/telescope-env.nvim" },

	-- LSP & Completion
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{
		src = "https://github.com/saghen/blink.cmp",
	},
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },

	-- Debugging
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/julianolf/nvim-dap-lldb" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },

	-- Misc
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
	{ src = "https://github.com/ej-shafran/compile-mode.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" }
})

-- ============================================================================
-- Plugin Configuration
-- ============================================================================

-- Colorscheme
require("tokyodark").setup({transparent_background = true})
vim.cmd("colorscheme tokyodark")

-- Tmux.nvim
require("tmux").setup({
	navigation = { enable_default_keybindings = false },
	resize = { enable_default_keybindings = true },
	copy_sync = { enable = true }
})

require("typst-preview").setup({
	debug = true,

	dependencies_bin = {
		tinymist = "tinymist",
		websocat = nil
	}
})

-- Lazydev (Lua LSP enhancements)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function ()
		require("lazydev").setup()
	end
})

-- Treesitter
local treesitter_langs = {
	"svelte", "markdown", "lua", "rust", "typst", "typescript", "javascript", "c", "cpp", "glsl", "zig", "python",
	"typescriptreact"
}

local typesetting_langs = { "md", "typst", "org" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = treesitter_langs,
	callback = function ()
		vim.treesitter.start()
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = typesetting_langs,
	callback = function ()
		vim.o.wrap = true
		vim.o.linebreak = true
		vim.o.spell = true
		vim.keymap.set('n', "j", "gj")
		vim.keymap.set('n', "k", "gk")
	end
})

-- LSP
vim.lsp.enable({
	"emmylua_ls",
	"cssls",
	"svelte",
	"tinymist",
	"rust_analyzer",
	"clangd",
	"ruff",
	"haskell-language-server",
	"hlint",
	"tailwindcss",
	"ts_ls",
	"basedpyright"
})

-- below made obsolete by blink.cmp
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("my.lsp", {}),
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--         if client:supports_method("textDocument/completion") then
--             -- Trigger autocompletion on every printable character
--             local chars = {}
--             for i = 32, 126 do
--                 chars[i - 31] = string.char(i)
--             end
--             client.server_capabilities.completionProvider.triggerCharacters = chars
--             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--         end
--     end,
-- })

-- blink.cmp
-- required to call .build():pwait() because native vim.pack does not have a build function

require('blink.cmp').build():pwait()
require('blink.cmp').setup({
})

-- Mason
require("mason").setup()

-- Telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40
		}
	}
})
telescope.load_extension("ui-select")

-- Actions preview
require("actions-preview").setup({
	backend = { "telescope" },
	telescope = require("telescope.themes").get_dropdown()
})

-- Oil
require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true
	},
	columns = { "icon" },
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded"
	}
})

-- Marks
require("marks").setup({
	builtin_marks = { "<", ">", "^" }
})

-- Gitsigns
require("gitsigns").setup()

-- LuaSnip
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

-- DAP
require("dap-lldb").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function ()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function ()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function ()
	dapui.close()
end

-- ============================================================================
-- Utility Functions
-- ============================================================================

local function pack_clean()
	local unused = {}
	for _, plugin in ipairs(vim.pack.get()) do
		if not plugin.active then
			table.insert(unused, plugin.spec.name)
		end
	end

	if #unused == 0 then
		print("No unused plugins.")
		return
	end

	if vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2) == 1 then
		vim.pack.del(unused)
	end
end

-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set
local builtin = require("telescope.builtin")
local ls = require("luasnip")

-- System clipboard
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "v", "x", "n" }, "<C-y>", '"+y', { desc = "Yank to system clipboard" })

-- Snippets
map(
	{ "i", "s" }, "<C-e>",
	function ()
		ls.expand_or_jump(1)
	end,
	{ silent = true }
)
map(
	{ "i", "s" }, "<C-J>",
	function ()
		ls.jump(1)
	end,
	{ silent = true }
)
map(
	{ "i", "s" }, "<C-K>",
	function ()
		ls.jump(-1)
	end,
	{ silent = true }
)

-- DAP
map("n", "<leader>d", ":DapNew<CR>", { desc = "New DAP session" })
map({ "n", "i" }, "<C-b>", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })

-- Terminal & Tabs
map({ "n", "t" }, "<Leader>t", "<Cmd>split<CR><Cmd>term<CR>i", { desc = "Open terminal" })
map({ "n", "t" }, "<Leader>x", "<Cmd>tabclose<CR>", { desc = "Close tab" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

for i = 1, 8 do
	map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end

-- Plugin management
map("n", "<leader>pc", pack_clean, { desc = "Clean unused plugins" })

-- Vimrc editing
map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>", { desc = "Edit init.lua" })
map({ "n", "v", "x" }, "<leader>z", "<Cmd>e ~/.config/zsh/.zshrc<CR>", { desc = "Edit .zshrc" })
map({ "n", "v", "x" }, "<leader>o", "<Cmd>source %<CR>", { desc = "Source current file" })
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>", { desc = "Restart Neovim" })

-- File operations
map({ "n", "v", "x" }, "<leader>r", ":edit!<CR>", { desc = "Reload current file" })
map({ "n", "v", "x" }, "<leader>a", ":edit #<CR>", { desc = "Switch to alternate buffer" })
map({ "n", "v", "x" }, "<leader>i", "<Cmd>tabedit .gitignore<CR>", { desc = "Edit .gitignore" })
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
map("n", "<C-f>", "<Cmd>Open .<CR>", { desc = "Open directory in file manager" })
map("n", "<leader>w", "<Cmd>update<CR>", { desc = "Save buffer" })
map("n", "<leader>q", "<Cmd>quit<CR>", { desc = "Quit buffer" })
map("n", "<leader>Q", "<Cmd>wqa<CR>", { desc = "Save all and quit" })

-- Navigation
map("n", "gl", "$", { desc = "End of line" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Visual mode
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map({ "n", "v", "x" }, "<CR>", ":", { desc = "Enter command mode" })

-- Search
map("n", "<ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })
map("n", "yag", ":%y<CR>", { noremap = true, silent = true, desc = "Yank all lines" })
map("n", "vag", "ggVG", { noremap = true, silent = true, desc = "Select all lines" })
map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Substitute (very nomagic)" })

-- Resize
map("n", "<M-n>", "<cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<M-e>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<M-i>", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })
map("n", "<M-m>", "<cmd>vertical resize -5<CR>", { desc = "Decrease width" })

-- Telescope
map("n", "<leader>f", builtin.find_files, { desc = "Find files" })
map("n", "<leader>g", builtin.live_grep, { desc = "Live grep" })
map(
	"n", "<leader>sg",
	function ()
		builtin.find_files({ no_ignore = true })
	end,
	{ desc = "Find all files" }
)
map("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>si", builtin.grep_string, { desc = "Grep string under cursor" })
map("n", "<leader>so", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>sm", builtin.man_pages, { desc = "Man pages" })
map("n", "<leader>G", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>sr", builtin.lsp_references, { desc = "LSP references" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sT", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
map("n", "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in buffer" })
map("n", "<leader>st", builtin.builtin, { desc = "Telescope pickers" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>se", "<cmd>Telescope env<cr>", { desc = "Environment variables" })
map("n", "<leader>sa", require("actions-preview").code_actions, { desc = "Code actions" })

-- Quickfix
map("n", "<C-q>", ":copen<CR>", { silent = true, desc = "Open quickfix" })

-- Oil & Compile
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open Oil file browser" })
map("n", "<leader>c", "<cmd>Compile<CR>", { desc = "Compile" })

-- Custom ex-mode mappings
vim.cmd(
	[[
    nnoremap g= g+
    nnoremap gK @='ddkPJ'<cr>
    xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
    noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
    noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
    noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
    noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
    xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]]
)
