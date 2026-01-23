-- Dynamically pick which venv folder exists
-- Just incase I need it for more than one plugin
local function detect_venv(cwd)
  if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
    return ".venv", cwd
  elseif vim.fn.isdirectory(cwd .. "/venv") == 1 then
    return "venv", cwd
  else
    return nil, nil
  end
end

local venv, venv_path = detect_venv(vim.fn.getcwd())

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- local on_attach = function(client, bufnr)
    --   client.offset_encoding = 'utf-16'
    -- end
    config = function()
      -- I don't remember what this is.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- == PYTHON SPECIFICS == --

      vim.lsp.config("basedpyright", {
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
      vim.lsp.enable("basedpyright")

      if venv then
        vim.lsp.enable("ruff")
      end

      -- == END PYTHON SPECIFICS == --

      vim.lsp.config("rust_analyzer", {
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
      vim.lsp.enable("rust_analyzer")

      vim.lsp.enable("bashls")
      vim.lsp.enable("dockerls")

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
