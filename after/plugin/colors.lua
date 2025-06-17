function ColorMyStuff(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)

  -- 0 is global space
  -- These set up my transparent background for regualr and floating windows in focus (normal)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyStuff()
