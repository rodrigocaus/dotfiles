# .bashrc

# Source ble.sh if session is not initialized
[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --attach=none

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# NVIDIA+Cuda
export PATH="${PATH}:/usr/local/cuda/bin"
if [ -n "$LD_LIBRARY_PATH" ]; then
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/cuda/lib64"
else
  # If it's not set, create it
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64"
fi

# Docker
export DOCKER_HOST=unix:///run/user/1000/docker.sock

# for KDE applications in GNOME Wayland to be resizable
export QT_QPA_PLATFORM=xcb

# XDG Home
XDG_CONFIG_HOME=$HOME/.config

# Starship
eval "$(starship init bash)"

# Attach ble.sh to current session
[[ ! ${BLE_VERSION-} ]] || ble-attach

