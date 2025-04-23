return {
  "stevearc/conform.nvim",
  -- format on save
  event = { "BufWritePre" }, -- format on save
  config = function()
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        python = { "isort", "ruff" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        json = { "prettier" },
        markdown = { "prettier" },
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format()
    end, { desc = "Format file with Conform" })
  end,
}

