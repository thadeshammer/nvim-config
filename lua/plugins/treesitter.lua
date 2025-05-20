return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {

			ensure_installed = {
				"bash",
				"c",
				"dockerfile",
				"hlsl",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"typescript",
				"vim",
				"vimdoc",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				-- NOTE: I disabled this disable because I want all the colors. -thades
				-- disable = { "c", "rust" },
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
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
		},
	},

	-- TODO: get this working
	-- keep the current function name at the top of the window
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},

	-- todo-comments.nvim configuration
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {
			-- Your todo-comments options
			keywords = {
				FIX = {
					icon = "", -- icon used for the sign, and in search results; needs nerd font
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "fixme", "bug", "fixit", "issue", "FIXME", "BUG", "FIXIT", "ISSUE" },
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "", color = "info", alt = { "todo" } },
				HACK = { icon = "", color = "warning", alt = { "hack" } },
				WARN = { icon = "", color = "warning", alt = { "warning", "xxx", "WARNING", "XXX" } },
				PERF = {
					icon = "",
					alt = { "optim", "performance", "optimize", "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				},
				NOTE = { icon = "", color = "hint", alt = { "info", "INFO" } },
				TEST = {
					icon = "",
					color = "test",
					alt = { "testing", "passed", "failed", "TESTING", "PASSED", "FAILED" },
				},
			},

			-- todo. hi
			highlight = {
				use_treesitter = true,
				comments_only = true,
				pattern = "<(KEYWORDS)s*[:.]",
			},
			-- ... other todo-comments options ...
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)
		end,
	},
}
