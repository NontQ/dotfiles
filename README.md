# Dotfiles

![GitHub last commit](https://img.shields.io/github/last-commit/NontQ/dotfiles)
![GitHub repo size](https://img.shields.io/github/repo-size/NontQ/dotfiles)
![GitHub stars](https://img.shields.io/github/stars/NontQ/dotfiles?style=social)
![GitHub issues](https://img.shields.io/github/issues/NontQ/dotfiles)
![GitHub forks](https://img.shields.io/github/forks/NontQ/dotfiles?style=social)
![GitHub license](https://img.shields.io/github/license/NontQ/dotfiles)
![GitHub pull requests](https://img.shields.io/github/issues-pr/NontQ/dotfiles)
![GitHub contributors](https://img.shields.io/github/contributors/NontQ/dotfiles)
![GitHub top language](https://img.shields.io/github/languages/top/NontQ/dotfiles)
[![Coverage Status](https://coveralls.io/repos/github/NontQ/dotfiles/badge.svg?branch=main)](https://coveralls.io/github/NontQ/dotfiles?branch=main)

This repository contains my personal dotfiles and configuration files. It includes setup scripts, configuration files, and tasks to automate the setup and maintenance of my development environment.

## Table of Contents

- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [Configuration](#configuration)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [FAQ](#faq)
- [Troubleshooting](#troubleshooting)

## Features

- Automated setup and configuration of development environment
- Easy management of dotfiles using `chezmoi`
- Task automation with `go-task`
- Integration with Homebrew for package management
- Customizable themes for Fish shell, Vim, and Tmux
- Regular updates for plugins and themes

## Setup

<details>
<summary>Click to expand setup instructions</summary>

### Prerequisites

The setup script will automatically install the following prerequisites if they are not already installed:

- [Homebrew](https://brew.sh/)
- [Git](https://git-scm.com/)
- [chezmoi](https://www.chezmoi.io/)

### Initial Setup

1. **Clone the repository**:

    ```bash
    git clone https://github.com/NontQ/dotfiles.git ~/dotfiles
    ```

2. **Navigate to the dotfiles directory**:

    ```bash
    cd ~/dotfiles
    ```

3. **Create the configuration file from the template**:

    ```bash
    cp config.env.template config.env
    ```

4. **Edit the `config.env` file**:

    Open the `config.env` file and fill in the required values.

5. **Run the setup script**:

    ```bash
    ./setup.sh
    ```

This will install the prerequisites, create symlinks for your dotfiles, install essential packages, and set up your environment.


</details>

## Usage

<details>
<summary>Click to expand usage instructions</summary>

### Taskfile

This repository uses `go-task` to automate various tasks. Below are the available tasks:

- **Setup the environment**:

    ```bash
    task setup
    ```

- **Update configurations**:

    ```bash
    task update
    ```

- **Clean up**:

    ```bash
    task clean
    ```

- **Install dependencies**:

    ```bash
    task install-deps
    ```

- **Update Homebrew packages**:

    ```bash
    task update-homebrew
    ```

- **Update Fish plugins**:

    ```bash
    task update-fish-plugins
    ```

- **Update Vim plugins**:

    ```bash
    task update-vim-plugins
    ```

- **Update k9s skins**:

    ```bash
    task update-k9s-skins
    ```

- **Configure GitHub authentication**:

    ```bash
    task configure-github-auth
    ```

- **Make scripts executable**:

    ```bash
    task make-scripts-executable
    ```

- **Apply user customizations**:

    ```bash
    task apply-customizations
    ```

- **Set the Message of the Day (MOTD)**:

    ```bash
    task set-motd
    ```

- **Display help message**:

    ```bash
    task help
    ```

### Homebrew

To manually update Homebrew packages:

```bash
brew update
brew upgrade
brew cleanup
```

### Fish Plugins

To manually update Fish plugins:

```bash
fish -c 'fisher update'
```

### Vim Plugins

To manually update Vim plugins:

```bash
vim +PlugUpdate +qall
```

</details>

## Configuration

<details>
<summary>Click to expand configuration instructions</summary>

### Environment Variables

The `config.env` file contains environment variables used by the setup script. Here is an example:

```dotenv
# GitHub Configuration (optional)
GITHUB_TOKEN="your_personal_access_token"
GITHUB_USER="your_github_username"
GITHUB_EMAIL="your_github_email"
REPO_URL="https://github.com/yourusername/dotfiles.git"

# Theme Configuration
FISH_THEME="Catppuccin Mocha"
STARSHIP_THEME="starship-tokyonight.toml"

# Extra Plugin Configuration
FISH_PLUGINS="bobthefish, fzf, z"

# Editor Customizations (Default: vim)
EDITOR="vim"

# Tmux Configuration
TMUX_THEME="dracula"
TMUX_PLUGINS="tmux-resurrect, tmux-continuum"

# Vim Configuration
VIM_THEME="gruvbox"
VIM_PLUGINS="nerdtree, vim-airline"
```

### Adding More Dotfiles

To add more dotfiles, update the `FILES` array in the `setup.sh` script:

```shell
declare -a FILES=(
  ".bashrc"
  ".vimrc"
  ".tmux.conf"
  ".config/fish/config.fish"
  ".zshrc"  # Example of an additional dotfile
)
```

</details>

## Screenshots

<details>
<summary>Terminal Setup</summary>

![Terminal Setup](https://via.placeholder.com/800x400.png?text=Terminal+Setup)

</details>

<details>
<summary>Vim Configuration</summary>

![Vim Configuration](https://via.placeholder.com/800x400.png?text=Vim+Configuration)

</details>

<details>
<summary>Tmux Configuration</summary>

![Tmux Configuration](https://via.placeholder.com/800x400.png?text=Tmux+Configuration)

</details>

## Contributing

If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## FAQ

<details>
<summary>Click to expand FAQ</summary>

### Can I use the GitHub API without authentication?

Yes, it is possible to use the GitHub API without authentication for public repositories, but there are some limitations to be aware of:

1. **Rate Limiting**: Unauthenticated requests are limited to 60 requests per hour per IP address. If you exceed this limit, you will receive a `403 Forbidden` response until the rate limit resets.
2. **Access Restrictions**: You can only access public repositories without authentication. If you need to access private repositories, you must provide a GitHub token.

In your script, since you are accessing public repositories, it should work without a GitHub token, but you need to be mindful of the rate limits.

### Example Script with GitHub Token

If you want to add authentication to avoid rate limiting, you can modify the `curl` command to include a GitHub token. Here's how you can do it:

```shell
#!/bin/bash

# Directory to store the skin files
SKINS_DIR="$HOME/.k9s/skins"

# GitHub repository and branch for k9s themes
REPO="derailed/k9s"
BRANCH="master"

# GitHub repository and branch for Catppuccin themes
CATPPUCCIN_REPO="catppuccin/k9s"
CATPPUCCUIN_BRANCH="main"

# Skin files to download from k9s repository
SKINS=(
  "dracula.yml"
  "solarized-dark.yml"
)

# Catppuccin themes to download
CATPPUCCIN_SKINS=(
  "catppuccin-latte.yml"
  "catppuccin-mocha-transparent.yml"
)

# Create the skins directory if it doesn't exist
mkdir -p "$SKINS_DIR"

# GitHub token for authentication (replace with your token)
GITHUB_TOKEN="your_github_token_here"

# Download each skin file from k9s repository using the GitHub API
for SKIN in "${SKINS[@]}"; do
  SKIN_URL="https://api.github.com/repos/$REPO/contents/skins/$SKIN?ref=$BRANCH"
  curl -sL -H "Accept: application/vnd.github.v3.raw" -H "Authorization: token $GITHUB_TOKEN" "$SKIN_URL" -o "$SKINS_DIR/$SKIN"
done

# Download each Catppuccin theme using the GitHub API
for SKIN in "${CATPPUCCIN_SKINS[@]}"; do
  SKIN_URL="https://api.github.com/repos/$CATPPUCCIN_REPO/contents/skins/$SKIN?ref=$CATPPUCCUIN_BRANCH"
  curl -sL -H "Accept: application/vnd.github.v3.raw" -H "Authorization: token $GITHUB_TOKEN" "$SKIN_URL" -o "$SKINS_DIR/$SKIN"
done
```

### How do I add new plugins?

To add new plugins for Fish, Vim, or Tmux, update the respective configuration files:

- **Fish**: Add the plugin to the `FISH_PLUGINS` variable in `config.env`.
- **Vim**: Add the plugin to the `VIM_PLUGINS` variable in `config.env`.
- **Tmux**: Add the plugin to the `TMUX_PLUGINS` variable in `config.env`.

### How do I change themes?

To change themes for Fish, Vim, or Tmux, update the respective theme variables in `config.env`:

- **Fish**: Update the `FISH_THEME` variable.
- **Vim**: Update the `VIM_THEME` variable.
- **Tmux**: Update the `TMUX_THEME` variable.

### How do I backup my current dotfiles?

To backup your current dotfiles, you can use the following commands:

```bash
task backup
```

### How do I restore my dotfiles from a backup?

To restore your dotfiles from a backup, you can use the following commands:

```bash
task restore
```

</details>

## Troubleshooting

<details>
<summary>Click to expand troubleshooting instructions</summary>

### Common Issues

1. **Permission Denied**: If you encounter a "Permission Denied" error, ensure that you have the necessary permissions to execute the scripts. You may need to run the script with `sudo` or change the file permissions using `chmod`.

    ```bash
    chmod +x setup.sh
    sudo ./setup.sh
    ```

2. **Missing Dependencies**: If you encounter errors related to missing dependencies, ensure that all prerequisites are installed. Refer to the [Prerequisites](#prerequisites) section for more details.

3. **Rate Limiting**: If you encounter rate limiting issues with the GitHub API, consider using a GitHub token for authentication. Refer to the [Example Script with GitHub Token](#example-script-with-github-token) section for more details.

4. **Symlink Issues**: If you encounter issues with symlinks, ensure that the target files and directories exist and that you have the necessary permissions to create symlinks.

    ```bash
    ln -s source_file target_file
    ```

5. **Homebrew Installation Issues**: If Homebrew is not installed correctly, follow the official [Homebrew installation guide](https://brew.sh/).

6. **chezmoi Issues**: If you encounter issues with `chezmoi`, ensure that it is installed correctly and that you have the necessary permissions to apply dotfiles.

    ```bash
    chezmoi doctor
    ```

7. **Fish Shell Issues**: If you encounter issues with the Fish shell, ensure that it is installed correctly and that your configuration files are in the correct location.

    ```bash
    fish -c 'echo $fish_user_paths'
    ```

### Getting Help

If you encounter any issues or have questions, feel free to open an issue on the [GitHub repository](https://github.com/NontQ/dotfiles/issues).


</details>

