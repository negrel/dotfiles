{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    programs.firefox = {
      enable = true;
      profiles.anegrel = {
        isDefault = true;
        search.default = "DuckDuckGo";
        search.force = true;
        settings = {
          "browser.search.region" = "FR";
        };

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
      };
    };

    dot-profile.scripts."00-firefox".text = ''
      export BROWSER=firefox
    '';
  };
}