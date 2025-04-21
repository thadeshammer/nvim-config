require("config.lazy")

require("thades")

-- if this is WSL, we want to disable the terminal
local is_wsl = vim.fn.has("wsl") == 1 or vim.loop.os_uname().release:lower():find("microsoft") ~= nil

if is_wsl then
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
end
