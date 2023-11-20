{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      scratch
    ];

    zshrc.scripts."scratch".text = ''
      tmpscr() {
        local tmpdir="$(mktemp -d)"
        scratch -y "$1" "$tmpdir"
        cd "$tmpdir"
        direnv allow
        $EDITOR .
      }
    '';
  };
}
