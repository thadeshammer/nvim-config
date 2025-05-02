return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.dockerls.setup{}

    -- Dynamically pick which venv folder exists
    -- Just incase I need it for more than one plugin
    local function detect_venv()
      local cwd = vim.fn.getcwd()
      if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
        return ".venv"
      elseif vim.fn.isdirectory(cwd .. "/venv") == 1 then
        return "venv"
      else
        return nil
      end
    end

    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      settings = {
        basedpyright = {
          venvPath = ".", -- relative to project root
          venv = detect_venv(),
        },
      },
    })
    
    lspconfig.ruff.setup({})
    lspconfig.bashls.setup({})

    vim.diagnostic.config({
      -- border makes it pretty, source will show me error msg source i.e. 'mypy' or 'ruff'
      float = { border = "rounded", source = "always" },
      -- virtual_text = { source = "if_many", } -- add source inline if multiple sources
    })

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
  end,
}

