vim.api.nvim_create_autocmd("FileType", {
  pattern = "gdshader",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

