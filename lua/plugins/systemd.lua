return {
  {
    "wgwoods/vim-systemd-syntax",
    ft = { "systemd" }, -- only load on systemd filetypes
    event = "BufReadPre *.service,*.socket,*.target,*.mount",
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "systemd" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.diagnostics.systemd, -- calls `systemd-analyze verify`
        },
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
}
