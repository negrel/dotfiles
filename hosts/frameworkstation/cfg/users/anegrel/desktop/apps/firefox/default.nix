{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      # Required for SpeechSynthesis API
      # https://support.mozilla.org/en-US/kb/speechd-setup?as=u&utm_source=inproduct
      speechd
    ];

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
        ];
      };
    };

    dot-profile.scripts."00-firefox".text = ''
      export BROWSER=firefox
    '';
  };
}
