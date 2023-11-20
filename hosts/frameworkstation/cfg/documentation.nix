{ pkgs, ... }:

{
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;
  documentation.doc.enable = true;

  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
