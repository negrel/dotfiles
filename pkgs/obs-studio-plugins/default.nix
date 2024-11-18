{ pkgs, ... }:

{
  advanced-masks = pkgs.stdenv.mkDerivation rec {
    name = "obs-advanced-masks";
    version = "1.1.0";

    src = pkgs.fetchzip {
      url =
        "https://github.com/FiniteSingularity/obs-advanced-masks/releases/download/v${version}/obs-advanced-masks-v${version}-ubuntu-22.04.tar.gz.zip";
      sha256 = "sha256-T99I7b5clTBoU9qyUzLBxkf25aW9kGcdGomf2hoKvbA=";
    };

    nativeBuildInputs = with pkgs; [ unzip ];

    buildPhase = ''
      tar -xzf *.tar.gz
    '';
    installPhase = ''
      # Path of shaders found using:
      # strace -f obs | rg \.effect
      mkdir -p $out/share/obs/obs-plugins/obs-advanced-masks $out/lib/obs-plugins
      cp -r obs-advanced-masks/bin/64bit/* $out/lib/obs-plugins
      cp -r obs-advanced-masks/data/* $out/share/obs/obs-plugins/obs-advanced-masks/
    '';
  };
}
