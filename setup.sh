#!/bin/sh

function post_setup() {
## POST SETUP

sudo pacman -S git nvim vim stow

echo "Cloning dotfiles"
git clone git@github.com:rustdevbtw/dotfiles .dotfiles
cd .dotfiles
echo "Syncing dotfiles"
stow .
echo "Syncing done"

echo "Installing paru"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

echo "Installing packages"
sudo paru -S hyprland sddm grim slurp wl-clipboard grub-btrfs qt6ct bat exa yazi lf rustup virt-manager qemu wine dosbox mold ttf-cascadia-code-nerd kitty warp-terminal swaync pipewire wireplumber polkit-kde-agent qt6-wayland
echo "Setting mold as default linker"
sudo cp /bin/ld /bin/ld.default
sudo ln -svf /bin/ld.mold /bin/ld

echo "Installing Rust"
rustup default stable

echo "Installing PKGX"
sh <(curl https://pkgx.sh)

echo "Starting services"
sudo systemctl enable --now sddm
sudo systemctl start sddm
## END POST SETUP
}

post_setup
