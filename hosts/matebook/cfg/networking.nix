{ ... }:

{
  # Pick only one of the below networking options.
  networking.networkmanager = {
    enable = true; # Easiest to use and most distros use this by default.
  };
}
