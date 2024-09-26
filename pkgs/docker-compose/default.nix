{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "docker-compose";
  runtimeInputs = with pkgs; [ docker ];
  checkPhase = "";
  text = ''
    exec ${pkgs.docker}/bin/docker compose $@
  '';
}
