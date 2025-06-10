# thades neovim config

This was initially setup for WSL. Trying to set it up to be as adaptable and agnostic as is reasonbable. Obviously
doomed to fail.

## Requirements

### C and Clang

```bash
sudo apt update
sudo apt install build-essential
```

### `pip` and `pipx` global and on PATH

### Language Servers

- global via `npm`
  - `bash-language-server`: `npm install -g bash-language-server`
  - everyone's favorite formatter `prettier`: `npm install -g prettier`
- global via `apt`
  - bash formatter: `sudo apt install shfmt`
- in `.venv`
  - formatter: `pip install ruff`
  - import sort: `pip install isort`
  - linting: `pip install basedpyright-langserver`
