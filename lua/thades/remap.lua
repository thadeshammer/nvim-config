vim.g.mapleader = " "

-- turn off the fatfinger traps
-- close windows with :q or :close deliberately; I'm so sick of ctrl-w,c closing shit on me.
vim.keymap.set("n", "<C-w>c", "<Nop>", { noremap = true, silent = true })

-- leader+pv opens netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- leader+y yank to win32yank; leader+p paste from win32yank
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to system clipboard" })

-- leader+p paste from system clipboard needs to be OS aware
-- note this is pretty janky, best not to trust leader+p <_< I may remove this
vim.keymap.set("n", "<leader>p", function()
  local is_wsl = vim.fn.has("wsl") == 1 or vim.loop.os_uname().release:lower():find("microsoft") ~= nil

  if is_wsl then
    vim.cmd([[r !win32yank.exe -o --lf]])
  else
    vim.cmd('normal "+p')
  end
end, { desc = "Paste from system clipboard (smart WSL-safe)" })

-- Keymaps for moving lines, alt+[dir] moves line(s)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- leader+v opens visual block mode (because ctrl-v in windows is paste)
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true, silent = true })

-- leader+md opens markdown preview in browser
vim.keymap.set("n", "<leader>md", ":MarkdownPreview<CR>", { desc = "Markdown preview start" })
vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Markdown preview stop" })

-- leader+lr reload lsp  for this file to rescan it
vim.keymap.set("n", "<leader>lr", function()
  local bufnr = vim.api.nvim_get_current_buf()

  for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    client.stop()
  end

  vim.cmd("edit")  -- Optional: forces re-read from disk
  require("conform").format()
end, { desc = "Restart LSP for current buffer" })

-- telescope controls
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP symbols (document)" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter symbols" })

-- Leader+" trigger Neogen docstring generation
-- vim.keymap.set("n", "<leader>c", function()
--   vim.cmd("Neogen")
-- end, { noremap = true, silent = true, desc = "Generate docstring with Neogen" })

vim.keymap.set("n", "<leader>c", function()
  require('neogen').generate()
end, { desc = "Generate docstring with Neogen" })

