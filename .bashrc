# Path to your dotfiles
export DOTFILES="$HOME/dotfiles"

# Environment Variables
export KUBE_EDITOR="nano"
export SHELL=$(which bash)
export TERM="xterm-256color"
export VISUAL="nano"
export EDITOR="nano"
export HOMEBREW_NO_ANALYTICS=1
export ANSIBLE_FORCE_COLOR=true
export ANSIBLE_HOST_KEY_CHECKING=False
export PY_COLORS=true
export GPG_TTY=$(tty)
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export TZ_LIST="America/Toronto"

# Set up Fisher (Fish plugin manager) equivalent for Bash
# Note: Fisher is specific to Fish shell. For Bash, you might use a different plugin manager or skip this section.

# Launch direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

# Load Homebrew environment if installed
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# fzf configuration
export FZF_DEFAULT_OPTS="--height 80% --reverse"
export PATH="$PATH:$HOME/.krew/bin"

# Load Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# Git alias
alias yolo='git add -A && git commit -m "$(curl -L -s whatthecommit.com/index.txt)"'