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

## Neovim Antigravity AI Integration

This configuration includes a custom Neovim plugin that embeds the **Antigravity CLI** (`agy`) directly into your editor with seamless, real-time buffer updates.

### Key Features
*   **Toggle Split (`<C-g>`)**: Press `<C-g>` in Normal or Terminal mode to toggle a vertical split on the far right running `agy`.
*   **Smart Focus**:
    *   If the AI window is closed, it opens a fresh vertical split.
    *   If the AI window is open but your cursor is in another file, `<C-g>` will **focus** (jump to) the AI window.
    *   If your cursor is inside the AI window, `<C-g>` **hides** it.
*   **Instant Real-Time Sync**: Fully integrates Neovim's `autoread` with a reduced `updatetime` (300ms) and automatic disk-checking (`checktime`). Any file edits written by the AI to your workspace are instantly reflected in your active buffer as soon as you pause typing.
*   **Buffer Lifecycle**: Auto-deletes terminal buffers safely when the AI session exits, and keeps your buffer switching list (`:bnext`/`:bprev`) clean by keeping the terminal unlisted.

---

## Customization

Feel free to customize these dotfiles to your liking. Remember to push your changes back to this repository to keep them synchronized.
