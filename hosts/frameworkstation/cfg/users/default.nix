{ ... }:

{
  users = {
    # Users created using `useradd` are deleted on nixos-rebuild.
    # This way, configuration.nix is the source of truth.
    mutableUsers = false;
  };
}
