return {
  {
    "wgwoods/vim-systemd-syntax",
    ft = { "systemd" }, -- only load on systemd filetypes
    event = "BufReadPre *.service,*.socket,*.target,*.mount",
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Register systemd-analyze for systemd filetypes
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft.systemd = { "systemd-analyze" }

      -- Automatically run the linter on save or leave insert mode
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
