{ pkgs, ... }:

let
  writeBinFile = { name, source, destination }:
    pkgs.runCommand name { inherit source destination; } ''
      target="$out/$destination"
      mkdir -p "$(dirname $target)"
      cp -f "$source" "$target"
    '';
  # gen-theme script
  gen-theme-bin = pkgs.writeShellApplication {
    name = "gen-theme";
    runtimeInputs = with pkgs; [ bash coreutils ];
    text = builtins.readFile ./bin/gen-theme;
  };

  # toggle-dark-mode script
  toggle-dark-mode = pkgs.writeShellApplication {
    name = "toggle-dark-mode";
    runtimeInputs = with pkgs; [ bash coreutils glib.bin ];
    text = builtins.readFile ./bin/toggle-dark-mode;
  };

  gen-theme-all-themes = pkgs.symlinkJoin {
    name = "gen-theme-all-themes";
    paths = [
      gen-theme-theme-moon
      gen-theme-theme-space
      gen-theme-theme-wallhaven
      gen-theme-theme-gruvbox
      gen-theme-theme-gruvbox-dark
    ];
  };

  gen-theme-theme-moon = pkgs.symlinkJoin {
    name = "gen-theme-theme-moon";
    paths = [ gen-theme-colorschemes-moon gen-theme-wallpapers-moon ];
  };

  gen-theme-wallpapers-moon = writeBinFile {
    name = "gen-theme-wallpapers-moon";
    source = ./wallpapers/moon.jpg;
    destination = "/etc/gen-theme/wallpapers/moon.jpg";
  };

  gen-theme-colorschemes-moon = pkgs.writeTextFile {
    name = "gen-theme-colorschemes-moon";
    text = builtins.readFile ./colorschemes/moon;
    destination = "/etc/gen-theme/colorschemes/moon";
  };

  gen-theme-theme-space = pkgs.symlinkJoin {
    name = "gen-theme-theme-space";
    paths = [ gen-theme-colorschemes-space gen-theme-wallpapers-space ];
  };

  gen-theme-wallpapers-space = writeBinFile {
    name = "gen-theme-wallpapers-space";
    source = ./wallpapers/space.jpg;
    destination = "/etc/gen-theme/wallpapers/space.jpg";
  };

  gen-theme-colorschemes-space = pkgs.writeTextFile {
    name = "gen-theme-colorschemes-space";
    text = builtins.readFile ./colorschemes/space;
    destination = "/etc/gen-theme/colorschemes/space";
  };

  gen-theme-theme-wallhaven = pkgs.symlinkJoin {
    name = "gen-theme-theme-wallhaven";
    paths = [ gen-theme-colorschemes-wallhaven gen-theme-wallpapers-wallhaven ];
  };

  gen-theme-wallpapers-wallhaven = writeBinFile {
    name = "gen-theme-wallpapers-wallhaven";
    source = ./wallpapers/wallhaven.jpg;
    destination = "/etc/gen-theme/wallpapers/wallhaven.jpg";
  };

  gen-theme-colorschemes-wallhaven = pkgs.writeTextFile {
    name = "gen-theme-colorschemes-wallhaven";
    text = builtins.readFile ./colorschemes/wallhaven;
    destination = "/etc/gen-theme/colorschemes/wallhaven";
  };

  gen-theme-theme-gruvbox = pkgs.symlinkJoin {
    name = "gen-theme-theme-gruvbox";
    paths = [ gen-theme-colorschemes-gruvbox gen-theme-wallpapers-moon ];
  };

  gen-theme-colorschemes-gruvbox = pkgs.writeTextFile {
    name = "gen-theme-colorschemes-gruvbox";
    text = builtins.readFile ./colorschemes/gruvbox;
    destination = "/etc/gen-theme/colorschemes/gruvbox";
  };

  gen-theme-theme-gruvbox-dark = pkgs.symlinkJoin {
    name = "gen-theme-theme-gruvbox";
    paths = [ gen-theme-colorschemes-gruvbox-dark gen-theme-wallpapers-moon ];
  };

  gen-theme-colorschemes-gruvbox-dark = pkgs.writeTextFile {
    name = "gen-theme-colorschemes-gruvbox";
    text = builtins.readFile ./colorschemes/gruvbox-dark;
    destination = "/etc/gen-theme/colorschemes/gruvbox-dark";
  };
in
pkgs.symlinkJoin rec {
  name = "gen-theme";
  themes = [ gen-theme-all-themes ];
  paths = [ gen-theme-bin toggle-dark-mode ] ++ themes;
}
