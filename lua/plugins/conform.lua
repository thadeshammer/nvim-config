return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" }, -- format on save
  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      -- for Normal mode, format full buffer
      mode = "n",
      desc = "Format entire buffer with Conform",
    },
    {
      "<leader>=",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      -- for Visual mode, format selection
      mode = "v",
      desc = "Format visual selection with Conform",
    },
  },

  opts = {

    format_on_save = function(bufnr)
      local exclusions = { "sh", "bash", "yaml.ansible" }
      -- check filetype of current buffer
      local ft = vim.bo[bufnr].filetype

      -- If it's excluded, don't auto format; else do
      for _, excluded_ft in ipairs(exclusions) do
        if ft == excluded_ft then
          return
        end
      end

      local timeout = 3000

      -- Otherwise, auto format
      return {
        lsp_fallback = true,
        timeout_ms = timeout,
      }
    end,

    formatters_by_ft = {
      python = { "isort", "ruff_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      rust = { "rustfmt" },
      ["yaml.ansible"] = { "prettier" },
      ["ansible"] = { "prettier" },
      jinja = { "prettier" },
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
        prepend_args = { "--prose-wrap", "always", "--print-width", "120", "--parser", "yaml", "--tab-width", "2" },
      },
      rustfmt = {
        command = "rustfmt",
        args = { "--emit=stdout" },
        stdin = true,
      },
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
      isort = {
        command = "./.venv/bin/isort", -- explicitly use project-local
        args = { "-" },
        stdin = true,
      },
      ["ansible-lint"] = {
        -- prepend_args = { "--fix", "all" },
        prepend_args = {},
      },
    },
  },
}
