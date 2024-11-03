{ pkgs, lib, ... }: {

  home-manager.users.anegrel = { ... }: {
    home.packages = with pkgs; [ mkcert ];

    # Copy mkcert rootCA files.
    home.file.".local/share/mkcert/rootCA.pem".text =
      lib.my.readSecretFile "mkcert/rootCA.pem";
    home.file.".local/share/mkcert/rootCA-key.pem".text =
      lib.my.readSecretFile "mkcert/rootCA-key.pem";
  };

  # Install mkcert rootCA.
  security.pki.certificates = [ (lib.my.readSecretFile "mkcert/rootCA.pem") ];
}
