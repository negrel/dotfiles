{ ... }:

{
  # Weekly garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 8d";
}
