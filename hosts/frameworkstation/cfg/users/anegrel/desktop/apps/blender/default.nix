{ pkgs, ... }:

{
  home-manager.users.anegrel = { lib, ... }: with lib; {
    home.packages = with pkgs; [
      blender-hip
      rocmPackages.llvm.llvm # Required to compile HIP render kernel.
    ];
  };
}
