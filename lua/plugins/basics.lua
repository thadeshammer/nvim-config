return {
  -- :Git
  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive"
  },

  -- ctrl-e for favorite file shortcut menu (for given proj dir)
  { "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- leader + u
  { "mbbill/undotree" },

  -- visual mode + gc to comment/uncomment lines
  { "tpope/vim-commentary" },

  -- S) to enclose in parens, S} to enclosein brackets, etc.
  { "tpope/vim-surround" },

  -- so I can git gud
  { "ThePrimeagen/vim-be-good" },
}

