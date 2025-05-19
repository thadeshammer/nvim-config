return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- fixes WARNING Found buffers attached to multiple clients with different position encodings.
		capabilities.offsetEncoding = { "utf-8" }

		local util = require("lspconfig.util")

		-- == PYTHON SPECIFICS == --

		-- Dynamically pick which venv folder exists
		-- Just incase I need it for more than one plugin
		local function detect_venv()
			local cwd = vim.fn.getcwd()
			if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
				return ".venv", cwd
			elseif vim.fn.isdirectory(cwd .. "/venv") == 1 then
				return "venv", cwd
			else
				return nil, nil
			end
		end

		local venv, venv_path = detect_venv()

		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			root_dir = vim.fn.getcwd(),
			settings = {
				basedpyright = {
					venvPath = venv_path,
					analysis = {
						diagnosticMode = "workspace",
					},
				},
			},

			on_attach = function(client, bufnr)
				-- bufnr doesn't exist in global scope, this keymap needs to happen here in on_attach.
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP hover doc" })
			end,
		})

		lspconfig.ruff.setup({})

		-- == END PYTHON SPECIFICS == --

		lspconfig.bashls.setup({})
		lspconfig.dockerls.setup({})

		vim.diagnostic.config({
			-- border makes it pretty, source will show me error msg source i.e. 'mypy' or 'ruff'
			float = { border = "rounded", source = "always" },
			-- virtual_text = { source = "if_many", } -- add source inline if multiple sources
		})

		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
	end,
}
