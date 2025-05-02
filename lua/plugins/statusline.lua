return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons


    config = function()

      local function smart_filename()
        local cwd = vim.fn.getcwd()
        local file = vim.fn.expand("%:p")
        if file:find(cwd, 1, true) == 1 then
          return vim.fn.fnamemodify(file, ":.")
        else
          return file
        end
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          -- lualine_c = { "filename" },
          lualine_c = { smart_filename },
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
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { smart_filename }, -- <- same filename logic
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

}

