return {
  -- to install in WSL:
  --  git clone https://github.com/iamcco/markdown-preview.nvim ~/.local/share/nvim/lazy/markdown-preview.nvim
  --  cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
  --  yarn install
  --
  --  no `yarn build` required
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
