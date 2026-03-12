{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-gnome3
  ];
  programs.gnupg.agent.enable = true;
}
