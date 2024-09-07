{ ... }:

{
  users.users.anegrel = { extraGroups = [ "syncthing" ]; };

  services.syncthing = {
    enable = true;
    user = "anegrel";
    dataDir = "/home/anegrel/Documents/syncthing/";
    configDir = "/home/anegrel/Documents/syncthing/.config";

    # overrides any devices added or deleted through the WebUI
    overrideDevices = true;
    # overrides any folders added or deleted through the WebUI
    overrideFolders = true;

    settings = {
      devices = {
        "Pixel 6" = {
          id =
            "4Y5GRTZ-UFPFFVJ-3UITU54-JVLIJ4P-TVL7JZ7-I6H67K2-SZ24LEV-WHBH7QU";
        };
      };
      folders = {
        "DCIM" = {
          path = "/home/anegrel/Documents/syncthing/pixel6/DCIM";
          id = "92ed1-8i26g";
          devices = [ "Pixel 6" ];
        };
        "Pictures" = {
          path = "/home/anegrel/Documents/syncthing/pixel6/Pictures";
          id = "ase6t-krb0n";
          devices = [ "Pixel 6" ];
        };
      };
    };
  };

  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
