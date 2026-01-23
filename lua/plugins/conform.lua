return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" }, -- format on save
  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer with Conform",
    },
  },

  opts = {

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
      rust = { "rustfmt" },
    },

    default_format_opts = {
      lsp_format = "fallback",
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
        args = { "--emit=stdout" },
        stdin = "true",
      },
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
    },

    isort = {
      command = "./.venv/bin/isort", -- explicitly use project-local
      args = { "-" },
      stdin = true,
    },
  },
}
