require("config.lazy")

require("thades")

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
