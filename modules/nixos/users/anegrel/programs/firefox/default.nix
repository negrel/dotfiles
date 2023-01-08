{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      darkreader
      multi-account-containers
      temporary-containers
      decentraleyes
      terms-of-service-didnt-read
      skip-redirect
    ];

    profiles.anegrel = {
      isDefault = true;
      search.default = "DuckDuckGo";
      search.force = true;
      settings = {
        "browser.search.region" = "FR";
      };
    };
  };

  home.file.".config/profile.d/00-firefox".text = ''
    export BROWSER=firefox
  '';
}
