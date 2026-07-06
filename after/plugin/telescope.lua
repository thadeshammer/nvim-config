local previewers = require("telescope.previewers")
local conf = require("telescope.config").values

require("telescope").setup({
  defaults = {
    preview = {
      timeout = 500, -- Increase timeout for slow NFS shares
      filesize_limit = 0.1, -- Limit previews to files < 100KB (optional)
    },
    dynamic_preview_title = true,

    grep_previewer = function(opts)
      -- Override "Grep Preview" with a hopefully identical doppleganger whose only difference
      -- is that instead of "Grep Preview" it puts the filename (basename)
      opts = opts or {}

      -- Override stock "Grep Previewer" so only the base filename shows in telescope find-file
      -- previewers (e.g. leader,f,f)
      return previewers.new_buffer_previewer({
        title = "Grep Preview",

        -- This is the property the engine natively looks for in low-level previewers
        dyn_title = function(_, entry)
          local path = entry.path or entry.value or ""
          if path ~= "" then
            return vim.fs.basename(path)
          end
          return "Grep Preview"
        end,

        -- Tell telescope how to identify the buffer uniquely
        get_buffer_by_name = function(_, entry)
          return entry.path or entry.value
        end,

        -- Delegate the rendering work to the default engine maker safely
        define_preview = function(self, entry, status)
          local path = entry.path or entry.value
          if path and path ~= "" then
            conf.buffer_previewer_maker(path, self.state.bufnr, {
              bufname = self.state.bufname,
              winid = self.state.winid,
              preview = opts.preview,
            })
          end
        end,
      })
    end,

    -- This is identical to grep previewer, but for capital-f File Previewer so that the recent
    -- files plugin (which doesn't use grep previewer) will also show only base filename in preview
    -- title
    file_previewer = function(opts)
      opts = opts or {}
      return previewers.new_buffer_previewer({
        title = "File Preview",
        dyn_title = function(_, entry)
          -- entry.path or entry.value ensures we catch recent_files' string structure
          local path = entry.path or entry.value or ""
          if path ~= "" then
            return vim.fs.basename(path)
          end
          return "File Preview"
        end,
        get_buffer_by_name = function(_, entry)
          return entry.path or entry.value
        end,
        define_preview = function(self, entry, status)
          local path = entry.path or entry.value
          if path and path ~= "" then
            conf.buffer_previewer_maker(path, self.state.bufnr, {
              bufname = self.state.bufname,
              winid = self.state.winid,
              preview = opts.preview,
            })
          end
        end,
      })
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
