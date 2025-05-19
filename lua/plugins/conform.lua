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
        python = { "isort", "ruff_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        rust = { "rustfmt" }
      },

      formatters = {
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
        prettier = {
          prepend_args = { "--prose-wrap", "always", "--print-width", "120" },
        },
        rustfmt = {
          command = "rustfmt",
          args = {"--emit=stdout"},
          stdin = "true"
        }

      },

      isort = {
        command = "./.venv/bin/isort",  -- explicitly use project-local
        args = { "-" },
        stdin = true,
      },

    })

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format()
    end, { desc = "Format file with Conform" })
  end,
}

