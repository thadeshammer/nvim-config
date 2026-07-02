require("telescope").setup({
  defaults = {
    preview = {
      timeout = 500, -- Increase timeout for slow NFS shares
      filesize_limit = 0.1, -- Limit previews to files < 100KB (optional)
    },
    dynamic_preview_title = true,
    buffer_previewer_maker = function(filepath, bufnr, opts)
      -- Extract just the filename from the absolute path
      opts = opts or {}
      opts.preview_title = vim.fs.basename(filepath)

      -- Fall back to the default maker with our custom title injected
      require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
    end,
  },
  extensions = {
    recent_files = {
      ignore_patterns = {
        ".git/COMMIT_EDITMSG",
      },
    },
  },
})

local builtin = require("telescope.builtin")

-- If I remember correctly, I do these here and not remap due to the nature of this being
-- loaded in after/
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "local system file search via telescope" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "git file search via telescope" })
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("telescope").load_extension("recent_files")
