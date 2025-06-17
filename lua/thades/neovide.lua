-- neovide stuff

if vim.g.neovide then
  -- "I'm not likely to use Neovide in any environment other than Windows." - Thades
  vim.o.guifont = "Agave Nerd Font:h14"

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end
