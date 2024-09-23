{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "tlsh";
  version = "4.8.2";

  src = pkgs.fetchFromGitHub {
    owner = "trendmicro";
    repo = "tlsh";
    rev = "4.8.2";
    sha256 = "sha256-kjv1Dp5YxG6U7JRa3oBmfkAg9N7A1YmWAQ0E3oWlsB8=";
  };

  nativeBuildInputs = with pkgs; [ cmake ];

  prePatch = "";
  configurePhase = "ls -l";
  buildPhase = ''
    sh make.sh
  '';
  installPhase = ''
    mkdir -p "$out"/bin
    cp bin/tlsh_unittest $out/bin/tlsh
  '';
}
