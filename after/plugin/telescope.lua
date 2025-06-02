require("telescope").setup({
  extensions = {
    recent_files = {
      ignore_patterns = {
        ".git/COMMIT_EDITMSG",
      },
    },
  },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "local system file search via telescope" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "git file search via telescope" })
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("telescope").load_extension("recent_files")
