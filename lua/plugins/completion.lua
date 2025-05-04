-- completions.lua

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",      -- LSP completions
      "hrsh7th/cmp-buffer",        -- buffer word completions
      "hrsh7th/cmp-path",          -- path completions
      "L3MON4D3/LuaSnip",          -- snippet engine
      "saadparwaiz1/cmp_luasnip",  -- LuaSnip integration
      "rafamadriz/friendly-snippets" -- VSCode-style snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- remaps Space to cancel auto-complete and put a literal space to keep typing 
          ["<Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close() -- space key closes the auto-complete pop-up
              vim.api.nvim_feedkeys(" ", "n", true) -- Insert a literal space
            else
              fallback()
            end
          end, { "i", "s" }),

          -- remaps Enter to cancel auto-complete and put a literal carriage return to keep typing 
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
              vim.api.nvim_feedkeys("\n", "n", true) -- Insert newline
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  }
}

