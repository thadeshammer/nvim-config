-- to clear out session cache in the event something in it is bad:
--  rm -rf ~/.local/share/nvim/sessions/
-- You may also need to clear ShaDa state for Telescope as well (recents list)
--  rm -rf ~/.local/state/nvim/shada/

return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_enable_last_session = false,
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = {
        "~/",
        "~/Downloads",
        "/",
        "/mnt/",
      },
      session_lens = { load_on_setup = false },
    })
  end,
}
