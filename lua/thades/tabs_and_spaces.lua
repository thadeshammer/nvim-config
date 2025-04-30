-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.textwidth = 120

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"json", "java", "python"},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4 
    vim.opt_local.expandtab = true
  end,
})

-- Filetype specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "xml",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"gdshader", "lua", "markdown"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
