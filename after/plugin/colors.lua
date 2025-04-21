function ColorMyStuff(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)

  -- 0 is global space
  --
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyStuff()
