vim.g.mapleader = " "

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
vim.keymap.set("n", "<leader>md", ":MarkdownPreviewStop<CR>", { desc = "Markdown preview stop" })
