{ ... }:

{
  # Pick only one of the below networking options.
  networking.networkmanager = {
    enable = true; # Easiest to use and most distros use this by default.
  };
  # Explicitly disabling it as it conflict with ISO module
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.
}
