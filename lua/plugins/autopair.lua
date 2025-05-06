-- lua/plugins/autopairs.lua
-- autopairs for () {} [] "" '' `` etc.
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- enable Treesitter integration
    map_bs = true, -- enable backspace to delete both in the pair
    enable_check_bracket_line = true, -- also for deletion I think
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

