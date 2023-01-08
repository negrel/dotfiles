{ pkgs, ... }:

{
  aichat =
    let
      rustPlatform = pkgs.makeRustPlatform {
        rustc = pkgs.rustc;
        cargo = pkgs.cargo;
      };
    in
    rustPlatform.buildRustPackage rec {
      pname = "aichat";
      version = "0.8.0";

      src = pkgs.fetchFromGitHub {
        owner = "sigoden";
        repo = pname;
        rev = "v${version}";
        sha256 = "sha256-E/QslRDeifFHlHUELv9rYHjfCAB1yXXiXlWOyPNkfps=";
      };

      cargoSha256 = "sha256-7TTHBeZ68G6k5eHBL1zDGsYiTyx27fBbN7Rl9AiZTng=";

      /* nativeBuildInputs = with pkgs; [ pkg-config ] ++ buildInputs; */
      /* buildInputs = with pkgs; [ openssl alsa-lib libclang ]; */
      /* LIBCLANG_PATH = "${pkgs.libclang.lib}/lib"; */
      doCheck = false; # Skip tests
    };
}
