-- OPTS
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.showtabline = 2
vim.o.signcolumn = "yes"
vim.o.winborder = "none"
vim.o.swapfile = false
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.wrap = false
vim.cmd("filetype plugin on")
vim.g.mapleader = " "

vim.o.background = "dark"
vim.o.guifont = "Cascadia Mono"

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

--- PACKAGING
--- note: neovim v0.12 and up required (nightly as of time of implementation)
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
	{ src = "https://github.com/rktjmp/lush.nvim" },

	-- lsp has caused me so much trouble lately
	-- might as well as add this while im at adding plugins
	{ src = "https://github.com/neovim/nvim-lspconfig", { type = "git", opt = true } },

	-- colorschemes
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/bjarneo/pixel.nvim" },
	{ src = "https://github.com/uloco/bluloco.nvim" },
	{ src = "https://github.com/ribru17/bamboo.nvim" },
	{ src = "https://github.com/webhooked/kanso.nvim" },
	{ src = "https://github.com/kamwitsta/vinyl.nvim" },
	{ src = "https://github.com/NLKNguyen/papercolor-theme" },

	-- neorg and deps
	{ src = "https://github.com/nvim-neorg/neorg" },
	{ src = "https://github.com/nvim-neorg/lua-utils.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/pysan3/pathlib.nvim" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/3rd/image.nvim" },

	-- coding
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/folke/trouble.nvim", { opt = true } },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },

	-- editor shit
	{
		src = "https://github.com/folke/persistence.nvim",
	},
})

--- PACKAGE CONFIG

-- require("colorizer").setup()
require("oil").setup()

require("mini.pick").setup()
require("mini.icons").setup()
require("mini.pairs").setup()

require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
				default_workspace = "notes",
			},
		},
		["core.export"] = {},
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
			},
		},
		["core.summary"] = {},
	},
})
require("zen-mode").setup()
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "norg_meta", "norg" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		disable = function(lang, buf)
			local max_filesize = 5 * 1024 * 1024 -- 5.0 MiB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

require("snacks").setup({
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	statuscolumn = { enabled = false },
	words = { enabled = true },
	zen = { enabled = true },
})

-- bla  don

require("blink.cmp").setup({
	completion = {
		menu = {
			draw = {
				columns = {
					{ "kind_icon", "label", gap = 1 },
					{ "kind", "label_description" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
				},
			},
		},
	},
})
require("trouble").setup()
require("persistence").setup()

--- KEYBINDS
vim.keymap.set("n", "<leader>s", ":update<CR>:so<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>h", ":nohl<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>[", ":bprev<CR>")
vim.keymap.set("n", "<leader>]", ":bnext<CR>")
vim.keymap.set("n", "<leader>d", ":bdel<CR>")

vim.keymap.set("n", "<leader>e", ":Oil<CR>")
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
---vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader><leader>", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>lq", ":Trouble diagnostics<CR>")

vim.keymap.set("n", "<leader>sl", function()
	require("persistence").load()
end)
vim.keymap.set("n", "<leader>ss", function()
	require("persistence").select()
end)
vim.keymap.set("n", "<leader>sL", function()
	require("persistence").load({ last = true })
end)
vim.keymap.set("n", "<leader>sd", function()
	require("persistence").stop()
end)

vim.keymap.set("n", "<leader>lq", ":Trouble diagnostics<CR>")
vim.keymap.set("n", "<leader>lq", ":Trouble diagnostics<CR>")

--- LSP
--- list of configured servers are available in .local/share/nvim/site/pack/core/opt/nvim-lspconfig/lsp/
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"basedpyright",
	"ruff",
	"ts_ls",
	"typescript-language-server",
	"superhtml",
	"stylua",
})

vim.cmd("set completeopt=menu,preview,noselect")

--- FINAL SETTINGS
---
vim.cmd("colorscheme bluloco")
