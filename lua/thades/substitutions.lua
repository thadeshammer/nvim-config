-- Text arrow substitution
vim.api.nvim_create_augroup("TxtArrowAbbrev", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "TxtArrowAbbrev",
  pattern = { "text", "markdown" },
  command = "iabbrev -> →",
})
