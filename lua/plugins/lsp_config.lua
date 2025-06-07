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

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- local on_attach = function(client, bufnr)
    --   client.offset_encoding = 'utf-16'
    -- end
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local util = require("lspconfig.util")

      -- == PYTHON SPECIFICS == --

      lspconfig.basedpyright.setup({
        capabilities = capabilities,
        root_dir = vim.fn.getcwd(),
        settings = {
          basedpyright = {
            venvPath = venv_path,
            analysis = {
              diagnosticMode = "workspace",
            },
            -- exclude venv from analysis
            exclude = { "**/.venv/**", "**/venv/**" },
          },
        },

        on_attach = function(client, bufnr)
          -- bufnr doesn't exist in global scope, this keymap needs to happen here in on_attach.
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP hover doc" })
        end,
      })

      if venv then
        lspconfig.ruff.setup({})
      end

      -- == END PYTHON SPECIFICS == --

      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
          },
        },
      })

      lspconfig.bashls.setup({})
      lspconfig.dockerls.setup({})

      vim.diagnostic.config({
        -- border makes it pretty, source will show me error msg source i.e. 'mypy' or 'ruff'
        float = { border = "rounded", source = "always" },
        severity_sort = true,
        -- virtual_text = { source = "if_many", } -- add source inline if multiple sources
      })

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
    end,
  },
}
