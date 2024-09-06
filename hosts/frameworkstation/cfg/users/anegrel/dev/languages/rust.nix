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
      cargo-llvm-lines
      clippy
      mold
    ];

    dot-profile.scripts."00-rust".text = ''
      export PATH="$PATH:$HOME/.cargo/bin"
    '';

    home.file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';

  };
}
