{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        minikube
        kubectl
      ];

      zshrc.scripts = {
        "minikube".text = ''
          alias mkube=minikube
          alias k="kubectl"

          source ${pkgs.minikube}/share/zsh/site-functions/_minikube
          source <(kubectl completion zsh)
        '';
      };
    };
}
