vim.g.mapleader = " "
-- jk escape
vim.keymap.set("i", "jk", "<esc>", { noremap = true, silent = true })

-- turn off the fatfinger traps
-- close windows with :q or :close deliberately; I'm so sick of ctrl-w,c closing shit on me.
vim.keymap.set("n", "<C-w>c", "<Nop>", { noremap = true, silent = true })

-- remap j and k movement in normal mode to respect visual instead of physical lines
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

-- leader+pv opens netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- leader+y yank to system clipboard; leader+p paste from system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to system clipboard" })
if not is_wsl then
  vim.keymap.set("n", "<S-Insert>", '"+p', { desc = "Paste from the system clipboard" })

  vim.keymap.set("i", "<S-Insert>", function()
    vim.api.nvim_put({ vim.fn.getreg("+") }, "c", true, true)
  end, { desc = "Paste from system clipboard" })
end

-- Keymaps for moving lines, alt+[dir] moves line(s)
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("x", "<leader>j", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<leader>k", ":m '<-2<CR>gv=gv")

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

  vim.cmd("edit") -- Optional: forces re-read from disk
  require("conform").format()
end, { desc = "Restart LSP for current buffer" })

-- leader+lr trigger formatter
vim.keymap.set("n", "<leader>lr", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format with Ruff" })

-- telescope controls
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fF", function()
  require("telescope.builtin").find_files({
    prompt_title = "Find All Files",
    hidden = true,
    no_ignore = false, -- keep respecting .gitignore if you like
    follow = true, -- follow symlinks
  })
end, { desc = "Find any file (including dotfiles)" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP symbols (document)" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "goto LSP definition" })
vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter symbols" })
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope: list diagnostics" })
vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  { noremap = true, silent = true }
)

-- Leader+cc trigger Neogen docstring generation
vim.keymap.set("n", "<leader>cc", function()
  require("neogen").generate()
end, { desc = "Generate docstring with Neogen" })

-- leader+/ to comment out stuff
vim.keymap.set("n", "<leader>/", ":normal gcc<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>/", ":normal gc<CR>", { noremap = true, silent = true })

-- rename symbol across project; needs lsp/basedpyright to have "workspace" diagnostic mode
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })

-- inject project path + file name on current line (uses cwd)
vim.keymap.set("n", "<leader>cf", function()
  vim.api.nvim_put({ vim.fn.fnamemodify(vim.fn.expand("%"), ":.") }, "c", true, true)
end, { desc = "Insert relative file path at cursor" })

-- harpoon
-- vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
-- vim.keymap.set("n", "<leader>hr", require("harpoon.mark").rm_file)
