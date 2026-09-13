{ ... }:

{
  networking.hostName = "frameworkstation";
  networking.networkmanager.enable = true;

  # DNSSEC validation is attempted, but if the server does not support DNSSEC
  # properly, DNSSEC mode is automatically disabled.
  services.resolved.settings.Resolve.DNSSEC = "allow-downgrade";
}
