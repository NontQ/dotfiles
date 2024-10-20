# config.fish

# Path to your dotfiles
set DOTFILES $HOME/dotfiles

# Environment Variables
set -gx KUBE_EDITOR nano
set -x SHELL (which fish)
set -x TERM xterm-256color
set -gx VISUAL nano
set -gx EDITOR nano
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx ANSIBLE_FORCE_COLOR true
set -gx ANSIBLE_HOST_KEY_CHECKING False
set -gx PY_COLORS true
set -gx GPG_TTY (tty)
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x TZ_LIST "America/Toronto"

# Set up Fisher (Fish plugin manager)
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
set fisher_path $XDG_CONFIG_HOME/fish/functions/fisher.fish
if not test -f $fisher_path
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

# Install plugins listed in fish_plugins
fisher update

# Launch direnv
if type -q direnv
  direnv hook fish | source
  set -g direnv_fish_mode eval_on_arrow
end

# Load Homebrew environment if installed
if status --is-interactive
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end 

# fzf configuration
set -gx FZF_DEFAULT_OPTS --height 80% --reverse
set -gx PATH $PATH $HOME/.krew/bin

# Load Starship prompt
starship init fish | source

# Git alias
alias yolo='git add -A && git commit -m "$(curl -L -s whatthecommit.com/index.txt)"'

# Source aliases
source $DOTFILES/.config/fish/aliases.fish