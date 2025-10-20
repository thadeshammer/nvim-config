-- /home/thades/.config/nvim/lua/plugins/venv_check.lua
-- Throw a warning if this is a Python project dir with a .venv and the .venv is not active

local function detect_venv(cwd)
  -- Returns true/false based on whether a venv folder exists at the project root
  if vim.fn.isdirectory(cwd .. "/.venv") == 1 or vim.fn.isdirectory(cwd .. "/venv") == 1 then
    return true
  end
  return false
end

-- Function to run the check and notification
local function venv_warning_check()
  local current_cwd = vim.fn.getcwd()

  -- Check if a venv directory exists
  local venv_exists = detect_venv(current_cwd)

  -- If no Python LSP is active, it's often a sign the environment isn't sourced.
  local python_lsp_active = false
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.name == "basedpyright" or client.name == "ruff_lsp" then
      python_lsp_active = true
      break
    end
  end

  -- Warn if a Venv exists BUT no Python LSP is currently running (suggesting the venv isn't sourced)
  if venv_exists and not python_lsp_active then
    vim.notify(
      "⚠️ WARNING: PYTHON .VENV DETECTED, but no Python LSP is active. Did you forget to activate the .venv?",
      vim.log.levels.WARN,
      { title = "Venv Alert" }
    )
  end
end

-- Return the setup block for lazy.nvim
return {
  {
    "thades-venv-check", -- Give it a unique, local name
    lazy = false,
    dir = vim.fn.stdpath("config") .. "/lua/plugins",
    event = "VimEnter", -- Trigger the check once Nvim is fully loaded
    config = venv_warning_check, -- Run the check function
  },
}
