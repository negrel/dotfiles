{ pkgs, ... }:

{
  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [
      cargo
      rustc
      rustfmt
      rust-analyzer
      cargo-audit
      cargo-watch
      cargo-vet
      cargo-bloat
      clippy
    ];

    dot-profile.scripts."00-rust".text = ''
      export PATH="$PATH:$HOME/.cargo/bin"
    '';
  };
}
