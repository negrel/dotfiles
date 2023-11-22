{ home-manager, pkgs, lib, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Adwaita'
      '';
  };

in
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Login manager
  services.greetd.enable = true;
  services.greetd.settings =
    let
      swayConfig = pkgs.writeText "greetd-sway-config" ''
        exec "${dbus-sway-environment}/bin/dbus-sway-environment"
        exec "${configure-gtk}/bin/configure-gtk"

        # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
        exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
        bindsym Mod4+shift+e exec swaynag \
          -t warning \
          -m 'What do you want to do?' \
          -b 'Poweroff' 'systemctl poweroff' \
          -b 'Reboot' 'systemctl reboot'

        # Keyboard
        input type:keyboard {
          xkb_layout fr
          repeat_delay 125
        }
      '';
    in
    {
      default_session = {
        user = "greeter";
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  environment.etc."greetd/environments".text = ''
    sway
    bash
  '';

  # Lock screen
  security.pam.services.gtklock = {
    # Keyring
    enableGnomeKeyring = true;
  };

  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      swaybg
      gtklock
      swayidle
      mako

      # CLI utils
      screenshot
      wmctl

      # https://nixos.wiki/wiki/Sway#Using_NixOS
      configure-gtk
      dbus-sway-environment
      glib
      gnome3.adwaita-icon-theme
      wdisplays
    ];

    # Configuration files
    home.file.".config/sway".source = ./config/sway;

    # Templates
    gen-theme.templates."sway".source = ./templates/sway;
  };
}
