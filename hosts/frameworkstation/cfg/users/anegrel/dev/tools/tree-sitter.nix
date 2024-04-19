{ pkgs, lib, ... }:

let
  grammars = lib.filterAttrs (key: value: lib.isDerivation value) pkgs.tree-sitter-grammars;
  grammarsSrc = lib.mapAttrs (key: value: value.src) grammars;
  hmGrammarsFile = lib.mapAttrs'
    (key: value: {
      name = ".local/share/tree-sitter/parsers/${key}";
      value = { source = value; };
    })
    grammarsSrc;
in
{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      tree-sitter
    ];

    home.file = hmGrammarsFile;

    gen-theme.templates."tree-sitter.json" =
      {
        text = ''
          {
            "parser-directories": ["/home/anegrel/.local/share/tree-sitter/parsers"],
            "theme": {
              "constructor": "#@@COLOR8@@",
              "constant.builtin": {
                "bold": true,
                "color": "#@@COLOR3@@"
              },
              "number": {
                "color": "#@@COLOR3@@",
                "bold": true
              },
              "constant": "#@@COLOR3@@",
              "punctuation.bracket": "#@@COLOR8@@",
              "embedded": null,
              "function": "#@@COLOR4@@",
              "string.special": "#@@COLOR5@@",
              "module": "#@@COLOR8@@",
              "variable.builtin": {
                "bold": true
              },
              "attribute": {
                "italic": true,
                "color": "#@@COLOR2@@"
              },
              "punctuation.delimiter": "#@@COLOR8@@",
              "type.builtin": {
                "color": "#@@COLOR4@@",
                "bold": true
              },
              "comment": {
                "color": "#@@COLOR8@@",
                "italic": true
              },
              "string": "#@@COLOR2@@",
              "keyword": "#@@COLOR7@@",
              "operator": {
                "color": "#@@COLOR8@@",
                "bold": true
              },
              "tag": "#@@COLOR2@@",
              "variable.parameter": {
                "underline": true
              },
              "function.builtin": {
                "color": "#@@COLOR4@@",
                "bold": true
              },
              "property": "#@@COLOR2@@",
              "type": "#@@COLOR4@@"
            }
          }
        '';
        destination = ".config/tree-sitter/config.json";
      };

    zshrc.scripts."tree-sitter".text = ''
      alias ts="tree-sitter"
      alias tsh="tree-sitter highlight"
    '';
  };
}
