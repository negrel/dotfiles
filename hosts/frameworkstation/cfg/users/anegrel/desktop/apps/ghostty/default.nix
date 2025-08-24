{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [ my.ghostty-intel ];

      home.file.".config/ghostty/config".source = ./config/config;

      gen-theme.templates."ghostty" = {
        text = builtins.readFile ./templates/theme;
        destination = ".config/ghostty/themes/theme";
      };

      dot-profile.scripts."00-ghostty".text = ''
        export TERMINAL="ghostty"
      '';
    };

  systemd.user.services.ghostty = {
    enable = true;
    description = "ghostty";
    after = [
      "graphical-session.target"
      "dbus.socket"
    ];
    requires = [ "dbus.socket" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "notify-reload";
      ReloadSignal = "SIGUSR2";
      BusName = "com.mitchellh.ghostty";
      ExecStart = "${pkgs.my.ghostty-intel}/bin/ghostty --launched-from=systemd";
      Restart = "always";
    };
  };
}
