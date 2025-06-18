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

This will create symbolic links for the configuration files in your home directory.
When Zsh starts on WSL, `.zshrc` automatically loads `.zshrc.wsl`, which sets useful
PATH entries and aliases for Windows tools.
