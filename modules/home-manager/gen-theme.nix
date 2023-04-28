{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.gen-theme;
  templatesToBashArray = (templates:
    let
      templatesWithDestination = builtins.filter (el: hasAttrByPath [ "value" "destination" ] el)
        (lib.my.attrsToList templates);
      templatesList = builtins.map
        (el: "\"" + cfg.outdir + el.name + ":" + el.value.destination + "\"")
        templatesWithDestination
      ;
    in
    lib.concatStringsSep " " templatesList
  );
in
{
  options.gen-theme = {
    enable = mkEnableOption { };
    theme = mkOption {
      type = types.str;
      default = "moon";
    };

    outdir = mkOption {
      type = types.str;
      default = "$HOME/.cache/theme/";
    };

    templates = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ gen-theme ];
      file = (lib.mapAttrs'
        (name: value: {
          name = ".config/gen-theme/templates/" + name;
          value = (lib.filterAttrs (name: value: name != "destination") value);
        })
        cfg.templates) // {
        ".config/gen-theme/colorschemes/".source = "${pkgs.gen-theme}/etc/gen-theme/colorschemes";
        ".config/gen-theme/wallpapers/".source = "${pkgs.gen-theme}/etc/gen-theme/wallpapers";
      };

      activation.gen-theme = hm.dag.entryAfter [ "reloadSystemd" "writeBoundary" ] ''
        OUT_DIR="${cfg.outdir}" $DRY_RUN_CMD ${pkgs.gen-theme}/bin/gen-theme ${cfg.theme}

        gen_theme_templates=(${templatesToBashArray cfg.templates})
        for template in "''${gen_theme_templates[@]}"; do
          src="$(cut -d ':' -f 1 <<< "$template")"
          dst="$(cut -d ':' -f 2 <<< "$template")"

          $DRY_RUN_CMD mkdir -p "$(dirname $dst)"
          $DRY_RUN_CMD ln -sf "$src" "$dst"
        done
      '';
    };
  };
}
