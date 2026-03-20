# Dotfiles

This repository contains my personal dotfiles. Follow these instructions to set up a new machine.

---

## Prerequisites

These instructions assume you are using Fedora.

### GNU Stow

```bash
sudo dnf install stow
```

### Neovim

```bash
sudo dnf install neovim
```

### Starship

```bash
sudo dnf copr enable atim/starship -y
sudo dnf install starship -y
```

### ble.sh

```bash
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local
rm -rf ble.sh
```

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/rodrigocaus/dotfiles.git ~/.dotfiles
```

### 2. Create symlinks with GNU Stow

This step will create symbolic links from the dotfiles in this repository to their appropriate locations in your home directory using GNU Stow.

First, navigate to your dotfiles directory:
```bash
cd ~/.dotfiles
```

Then, for each configuration you want to activate, run `stow`:

```bash
stow --adopt bash
stow ble
stow nvim
stow starship
```

To remove symlinks (e.g., if you want to deactivate a configuration):
```bash
stow -D bash
```

---

## What's Included

*   **`bash/`**: Bash shell configuration (`.bashrc`)
*   **`ble/`**: ble.sh configuration (`.blerc`)
*   **`nvim/`**: Neovim configuration (`init.lua`, `lua/`)
*   **`starship/`**: Starship prompt configuration (`starship.toml`)

---

## Customization

Feel free to customize these dotfiles to your liking. Remember to push your changes back to this repository to keep them synchronized.
