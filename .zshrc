# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# ZSH_THEME="robbyrussell"
# ZSH_THEME="wedisagree"
# ZSH_THEME="blinks"
# ZSH_THEME="nicoulaj"
ZSH_THEME="mh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(z osx vagrant github brew)
plugins=(z)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source ~/.zshrc.custom

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/takanori.uzuka/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/takanori.uzuka/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/takanori.uzuka/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/takanori.uzuka/google-cloud-sdk/completion.zsh.inc'; fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

case "$(uname -s)" in
  Linux)
    if grep -qi Microsoft /proc/version 2>/dev/null; then
      [ -f ~/.zshrc.wsl ] && source ~/.zshrc.wsl
    else
      [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
    fi
    ;;
  Darwin)
    [ -f ~/.zshrc.osx ] && source ~/.zshrc.osx
    ;;
esac
