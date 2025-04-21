return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

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

    lspconfig.ruff.setup({
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
      float = { border = "rounded" },
    })

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
  end,
}

