{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      castnow
    ];
  };

  networking.firewall.extraCommands = ''
    iptables -A INPUT -p udp --sport 5353 -j ACCEPT
    iptables -A INPUT -p tcp --dport 4100 -j ACCEPT
  '';
}
