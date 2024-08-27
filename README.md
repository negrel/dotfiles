# Dotfiles - Nix Flakes of my configurations.

## Install

First, execute the following steps:
- Download NixOS ISO from the official [download page](https://nixos.org/download.html#download-nixos)
- Flash downloaded ISO on a USB stick (using `dd` for example)
- Boot USB stick and execute the following commands:

```shell
# Follow NixOS pre-installation steps manual (everything except nixos-install)
# https://nixos.org/manual/nixos/stable/

# Update channels & install git
nix-channel --update
...

nix-env -i git

# Clone this repository
git clone https://github.com/negrel/dotfiles

# Generate configuration.nix and hardware-configuration.nix
cd dotfiles
nixos-generate-config --root .

# Overwrite hardware-configuration of one of the host
host="<host>"
mv etc/nixos/hardware-configuration.nix "hosts/$host/"

# Add bootloader entry in hardware-configuration
# NOTE: NixOS place bootloader configuration in configuration.nix by default.
nano "hosts/$host/hardware-configuration.nix"

# Install
nixos-install --flake ".#$host"
...
```

Reboot and that's it, your system is live.

## :stars: Show your support

Please give a :star: if this project helped you!

[![buy me a coffee](https://github.com/negrel/.github/raw/master/.github/images/bmc-button.png?raw=true)](https://www.buymeacoffee.com/negrel)

## :scroll: License

MIT © [Alexandre Negrel](https://www.negrel.dev/)
