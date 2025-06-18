# Config files

## brew メモ

brew install ack coreutils ctags jq openssl readline shellCheck terminal-notifier the_silver_searcher tig tree wget zsh

## Using on WSL

Clone this repository inside your WSL environment and run the setup script.

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

The setup script ensures the English UTF-8 locale is available so that commands
such as `man` do not show locale related warnings.

This will create symbolic links for the configuration files in your home directory.
When Zsh starts on WSL, `.zshrc` automatically loads `.zshrc.wsl`, which sets useful
PATH entries and aliases for Windows tools.

## Neovim configuration

This repository provides a Lua-based configuration for Neovim under the
`nvim` directory. Running `setup.sh` creates a symbolic link at
`~/.config/nvim` pointing to this folder so that Neovim automatically loads
`init.lua`. When Neovim starts via the provided `.vimrc`, it forwards to this
Lua configuration.
