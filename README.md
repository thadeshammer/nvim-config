This was initially setup for WSL. Trying to set it up to be as adaptable and agnostic as is reasonbable.
Obviously doomed to fail.

== Requirements

- C and Clang

  ```bash
  sudo apt update
  sudo apt install build-essential
  ```

- `npm`
  - `bash-language-server`
  - `prettier`
- `pip` and possibly `pipx` (these are needed in global / on PATH)
  - `ruff` via pip
  - `isort` via pip or apt
    vim.g.mkdp_browser = "firefox"
- `sudo apt install shfmt`
