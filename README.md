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
When running `setup.sh` on WSL, `.vimrc` is linked to `.vimrc_wsl` so that Vim uses a minimal configuration that avoids plugin errors.
