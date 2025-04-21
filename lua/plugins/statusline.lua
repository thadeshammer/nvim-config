return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons

    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { 
            "encoding",
            "fileformat",
            "filetype",

            function()
              local venv = os.getenv("VIRTUAL_ENV")
              if venv then
                return " " .. vim.fn.fnamemodify(venv, ":t")
              else
                return ""
              end
            end,
          },

          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

}

