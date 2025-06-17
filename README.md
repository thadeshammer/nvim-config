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

- global via `apt`
  - bash formatter: `sudo apt install shfmt`
- global via `cargo`:
  - `cargo install stylua`
- global via `npm`
  - `bash-language-server`: `npm install -g bash-language-server`
  - everyone's favorite formatter `prettier`: `npm install -g prettier`
  - `npm install -g yarn` then `yarn install && yarn build && yarn run`
    - No, I don't remember what those three invocations do, Thades.
- not global, in `.venv`
  - formatter: `pip install ruff`
  - import sort: `pip install isort`
  - linting: `pip install basedpyright-langserver`
