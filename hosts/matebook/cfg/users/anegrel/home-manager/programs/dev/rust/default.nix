{ pkgs, ... }:

{
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

  home.file.".config/profile.d/00-rust".text = ''
    export PATH="$PATH:$HOME/.cargo/bin"
  '';
}
