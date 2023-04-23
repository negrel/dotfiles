{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.wrapped-hyprland;

in
{
  options.programs.wrapped-hyprland = {
    enable = mkEnableOption { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wrapped-hyprland
      (hyprland.overrideAttrs (prevAttrs: rec {
        postInstall =
          let
            de-entry = ''
              [Desktop Entry]
              Name=Hyprland
              Comment=An intelligent dynamic tiling Wayland compositor
              Exec=wrapped-hyprland
              Type=Application
            ''; in
          ''
            mkdir -p "$out/share/wayland-sessions"
            cat > "$out/share/wayland-sessions/hyprland.desktop" <<EOF
            ${de-entry}
            EOF
          '';
        passthru.providedSessions = [ "hyprland" ];
      }))
    ];
    services.xserver.displayManager.sessionPackages = with pkgs; [
      (hyprland.overrideAttrs (prevAttrs: rec {
        postInstall =
          let
            de-entry = ''
              [Desktop Entry]
              Name=Hyprland
              Comment=An intelligent dynamic tiling Wayland compositor
              Exec=wrapped-hyprland
              Type=Application
            ''; in
          ''
            mkdir -p "$out/share/wayland-sessions"
            cat > "$out/share/wayland-sessions/hyprland.desktop" <<EOF
            ${de-entry}
            EOF
          '';
        passthru.providedSessions = [ "hyprland" ];
      }))
    ];
    programs.hyprland.enable = true;
  };
}
