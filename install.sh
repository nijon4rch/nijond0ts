#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "========================================================================"
echo " WARNING: This script is currently untested."
echo " It is built for a specific system configuration and is highly"
echo " recommended to be run on a CLEAN INSTALL ONLY."
echo "========================================================================"
read -p "Press Enter to acknowledge and continue, or Ctrl+C to abort..."


echo "--> Copying /etc configurations..."
sudo cp -r "$SCRIPT_DIR/.dots/etc/"* /etc/

echo "--> Updating the system..."
sudo pacman -Syu

echo "--> Installing dependencies..."
sudo pacman -S rustup
rustup default stable

if ! command -v paru &> /dev/null; then
    echo "--> Paru not found. Installing Paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si)
    rm -rf /tmp/paru
else
    echo "--> Paru is already installed. Skipping build."
fi

echo "--> Installing CachyOS repos & packages..."
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-27-1-any.pkg.tar.zst'
sudo pacman --config /etc/pacman-cachyos.conf -Sy --needed cachyos-keyring cachyos-v3-mirrorlist cachyos-mirrorlist pacman
sudo pacman -S pahole bpf jq egl-wayland egl-gbm egl-x11 lib32-libglvnd
sudo pacman --config /etc/pacman-cachyos.conf -Sy --needed linux-cachyos linux-cachyos-headers scx-scheds nvidia-580xx-dkms
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "--> Installing dotfiles..."
if command -v rsync &> /dev/null; then
    rsync -a --exclude='.git/' --exclude="$(basename "${BASH_SOURCE[0]}")" --exclude='.dots/' "$SCRIPT_DIR/" "$HOME/"
else
    # Fallback to standard copy if rsync is missing
    cp -r "$SCRIPT_DIR/"* "$HOME/"
fi

echo "--> Installing essential packages..."
if [ -f "$SCRIPT_DIR/.dots/packages/essential" ]; then
    # Reading into an array safely handles lists separated by newlines and ignores empty lines
    mapfile -t essential_pkgs < <(grep -v '^\s*$' "$SCRIPT_DIR/.dots/packages/essential")
    if [ ${#essential_pkgs[@]} -gt 0 ]; then
        paru -S --needed --noconfirm "${essential_pkgs[@]}"
    fi
fi

echo "--> Installing AUR packages..."
if [ -f "$SCRIPT_DIR/.dots/packages/aur" ]; then
    mapfile -t aur_pkgs < <(grep -v '^\s*$' "$SCRIPT_DIR/.dots/packages/aur")
    if [ ${#aur_pkgs[@]} -gt 0 ]; then
        paru -S --needed --noconfirm "${aur_pkgs[@]}"
    fi
fi

echo "============================================================================"
echo " Telegram does not allow setting a theme directly from the CLI."
echo " A theme file is located at: $SCRIPT_DIR/.dots/nijond0ts.tdesktop-theme"
echo " Please apply it manually and press Enter to proceed. File will be deleted."
echo "============================================================================"
read -p "Press enter to proceed."

echo "--> Changing default shell to fish..."
sudo usermod -s /usr/bin/fish "$USER"

# Apply CachyOS tweaks
echo "--> Applying CachyOS tweaks..."
git clone https://github.com/CachyOS/cachyos-settings.git /tmp/cachyos-settings
(
    cd /tmp/cachyos-settings
    sudo mkdir -p /etc/sysctl.d /etc/udev/rules.d /etc/modprobe.d
    sudo cp -r usr/lib/sysctl.d/* /etc/sysctl.d/
    sudo cp -r usr/lib/udev/rules.d/* /etc/udev/rules.d/
    sudo cp -r usr/lib/modprobe.d/* /etc/modprobe.d/
)
rm -rf /tmp/cachyos-settings

echo "--> Making $HOME/.local/bin/ scripts executable..."
chmod +x "$HOME/.local/bin/"* 2>/dev/null

echo "--> Enabling and starting OpenRC services..."
OPENRC_SERVICES=("bluetoothd" "iwd" "chrony" "metalog" "scx") 

for svc in "${OPENRC_SERVICES[@]}"; do
    if [ -e "/etc/init.d/$svc" ]; then
        sudo rc-update add "$svc" default
        sudo rc-service "$svc" start
    else
        echo "Service '$svc' not found in /etc/init.d/, skipping..."
    fi
done

sudo openresolv -u

echo "--> Installation complete! Please reboot."
