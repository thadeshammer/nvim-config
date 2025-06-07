local function detect_venv()
  local cwd = vim.fn.getcwd()
  if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
    return ".venv", cwd
  elseif vim.fn.isdirectory(cwd .. "/venv") == 1 then
    return "venv", cwd
  else
    return nil, nil
  end
end

local venv, venv_path = detect_venv()

return {
  {
    "mfussenegger/nvim-lint",
    cond = venv ~= nil,
    config = function()
      require("lint").linters_by_ft = {
        python = { "mypy" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
