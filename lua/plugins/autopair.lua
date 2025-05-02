-- lua/plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- enable Treesitter integration
    disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)

    -- Optional: if using nvim-cmp
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}

