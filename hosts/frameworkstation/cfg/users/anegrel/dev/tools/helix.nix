{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [ helix ];
      home.file.".config/helix/config.toml".text = ''
        theme = "gruvbox_dark_hard"

        [editor]
        line-number = "relative"
        mouse = false

        [editor.cursor-shape]
        insert = "bar"
        normal = "block"
        select = "bar"

        [editor.file-picker]
        hidden = false
      '';
    };
}
