return {
  -- this works, hurrah
  {
    "danymat/neogen",
    version = "*", -- use stable
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()

      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings"
            },
          },
        },
      })

    end
  }

}

