-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.syntax = "on"
opt.cursorline = true
opt.cmdheight = 2
opt.encoding = "utf-8"
opt.termguicolors = true
opt.mouse = "a"

-- mapping
local map = vim.keymap.set

-- quit, save files using leader key

map("n", "<Leader>w", ":write<CR>")
map("n", "<Leader>q", ":wq<CR>")

-- Neotree
map("n", "<Leader>e", ":Neotree toggle<CR>")

-- telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })

-- config and init plugins
require("config.lazy")
require("neo-tree").setup({})
require("lualine").setup()
require("mason").setup()
require("bufferline").setup({})

require("goto-preview").setup({
	width = 120, -- Width of the floating window
	height = 15, -- Height of the floating window
	border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
	default_mappings = false, -- Bind default mappings
	debug = false, -- Print debug information
	opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
	resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
	post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
	post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
	references = { -- Configure the telescope UI for slowing the references cycling window.
		provider = "telescope", -- telescope|fzf_lua|snacks|mini_pick|default
		telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
	},
	-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
	focus_on_open = true, -- Focus the floating window when opening it.
	dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
	force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
	bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
	stack_floating_preview_windows = true, -- Whether to nest floating windows
	same_file_float_preview = true, -- Whether to open a new floating window for a reference within the current file
	preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
	zindex = 1, -- Starting zindex for the stack of floating windows
	vim_ui_input = true, -- Whether to override vim.ui.input with a goto-preview floating window
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
