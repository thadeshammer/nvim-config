require("config.lazy")

require("thades")

-- reduce modifier key time hopefully
vim.o.timeout = true
vim.o.timeoutlen = 800

-- if this is WSL, we want to disable the terminal
local is_wsl = vim.fn.has("wsl") == 1 or vim.loop.os_uname().release:lower():find("microsoft") ~= nil

if is_wsl then
  -- prevent windows CRLF line endings
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\r\+$//e]],
  })

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
  -- note: iconv is used to prevent utf-8 non-English characters from being mangled when landing in
  -- Windows; and powershell replace is used to redact Windows line-endings when landing in nvim.
  vim.g.clipboard = {
    name = "wsl clipboard",
    -- This copy works but does not emit utf-8 to utf-16 correctly so pasting non-English characters
    -- out to Windows fails / gets mangled.
    -- So far I've tried six ways to Sunday of piping the buffer through iconv to get it to utf-16
    -- for Windows but either it's still mangled or I cannot get WsL+Lua+bash+Windows to all agree
    -- on what an EOF looks like; so the problem is Windows really.
    copy = {
      ["+"] = [[clip.exe]],
      ["*"] = [[clip.exe]],
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

-- At start up check for .venv / venv and if present, warn if $VIRTUAL_ENV is not set
vim.api.nvim_create_augroup("CheckVenvOnEnter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "CheckVenvOnEnter",
  -- pattern = { "*.py", "**/*.py" },
  callback = function()
    local cwd = vim.fn.getcwd()
    local venv_exists = vim.fn.isdirectory(cwd .. "/.venv") == 1 or vim.fn.isdirectory(cwd .. "/venv") == 1
    local virtual_env_not_set = vim.fn.empty(vim.env.VIRTUAL_ENV or "") == 1
    if venv_exists and virtual_env_not_se then
      vim.notify(
        "WARNING! Found virtualenv folder but VIRTUAL_ENV not set. Did you forget to activate?",
        vim.log.levels.WARN
      )
    end
  end,
})
