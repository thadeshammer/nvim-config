-- Text arrow substitution
-- vim.api.nvim_create_augroup("TxtArrowAbbrev", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   group = "TxtArrowAbbrev",
--   pattern = { "text", "markdown" },
--   command = "iabbrev <buffer> -> →",
-- })

local txt_arrow_grp = vim.api.nvim_create_augroup("TxtArrowAbbrev", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = txt_arrow_grp,
  pattern = { "text", "markdown" },
  callback = function(args)
    -- make "->" expand to a real arrow in insert mode
    vim.keymap.set("i", "->", "→", { buffer = args.buf, desc = "Replace -> with →" })
  end,
})
