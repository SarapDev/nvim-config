# Dev Environment Setup

This repository contains an Ansible playbook to automate the setup of a development environment, specifically tailored for Neovim with support for Java (jEnv), Node.js (NVM), Go, Rust, Python, and Ruby.

## Prerequisites

Before running the playbook, ensure you have the following installed:

### macOS
1. **Homebrew**:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. **Ansible**:
   ```bash
   brew install ansible
   ```

### Linux (Debian/Ubuntu)
```bash
sudo apt update
sudo apt install ansible git -y
```

### Linux (Fedora)
```bash
sudo dnf install ansible git -y
```

## Installation

1. **Clone your configuration**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   cd ~/.config/nvim
   ```

2. **Run the Playbook**:
   ```bash
   ansible-playbook playbook.yml
   ```
   *Note: On Linux, you might be prompted for your sudo password.*

## Post-Installation Steps

### 1. Shell Configuration
Add the following lines to your `~/.zshrc` (or `~/.bashrc`) to initialize the version managers:

```bash
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# jEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Go
export PATH="$HOME/go/bin:$PATH"
```

Then reload your shell: `source ~/.zshrc`.

### 2. Neovim Plugins
Open Neovim and install the plugins using `vim-plug`:
```vim
:PlugInstall
```

### 3. Language Servers
Most language servers are installed automatically by the playbook. For Treesitter parsers, run:
```vim
:TSUpdate
```

## Features Included
- **Neovim**: Custom config with `vim-plug`.
- **NVM**: Node.js version management (defaulting to v20.15.1).
- **jEnv**: Java version management with OpenJDK 11 and 25.
- **LSPs**: Support for Java, Go, Python, Rust, C/C++, Vue, TypeScript, and more.
- **Terminals**: iTerm2 and Kitty (macOS) or Kitty (Linux).
- **Shell**: zsh.

## Troubleshooting
- **macOS**: If a Homebrew task fails, try running `brew doctor`.
- **Permissions**: If you encounter permission errors on Linux, ensure you are running with `become: true` where necessary (handled by the playbook, but requires sudo access).
