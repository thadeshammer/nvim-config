require("config.lazy")

require("thades")

-- reduce modifier key time hopefully
vim.o.timeout = true
vim.o.timeoutlen = 400

-- if this is WSL, we want to disable the terminal
local is_wsl = vim.fn.has("wsl") == 1 or vim.loop.os_uname().release:lower():find("microsoft") ~= nil

if is_wsl then
  -- disable in-nvim terminal in WSL, it skyrockets CPU usage
  vim.cmd([[
    function! s:DisableTermWSL() abort
      echohl ErrorMsg
      echoerr "':term' and ':terminal' are disabled in WSL due to high CPU usage."
      echohl None
      return ""
    endfunction

    cabbrev term <C-R>=<SID>DisableTermWSL()<CR>
    cabbrev terminal <C-R>=<SID>DisableTermWSL()<CR>
    ]])

  -- clip.exe for leader+y
  -- this is WAY faster than win32yank and why did I not see this before
  vim.g.clipboard = {
    name = "wsl clipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = "powershell.exe -command \"Get-Clipboard | ForEach-Object { $_ -replace '\\r', '' }\"",
      ["*"] = "powershell.exe -command \"Get-Clipboard | ForEach-Object { $_ -replace '\\r', '' }\"",
    },
    cache_enabled = 1,
  }
end

-- disable wordwrap for source code files (list obviously not exhaustive)
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "python",
    "lua",
    "javascript",
    "typescript",
    "c", -- C
    "cpp", -- C++
    "gdscript", -- Godot GDScript
    "gdshader", -- (Godot shader files)
    "java",
    "sh", -- bash / shell scripts
    "bash",
    "rust",
  },
  callback = function()
    vim.opt_local.formatoptions:remove("t") -- don't auto-wrap all text
    vim.opt_local.formatoptions:append("c") -- wrap comments using 'textwidth'
    vim.opt_local.formatoptions:append("q") -- allow formatting comments with gq
    vim.opt_local.formatoptions:append("r") -- continue comment on newline
    vim.opt_local.formatoptions:append("n") -- recognize numbered lists
    vim.opt_local.textwidth = 100
  end,
})
