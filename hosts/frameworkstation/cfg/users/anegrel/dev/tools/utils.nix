{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [
        # Watch FS changes
        inotify-tools

        # Run arbitrary commands when files change
        entr

        # count LOC, comments, etc.
        cloc

        # Run process in cgroup with quotas.
        my.run-with-quotas
      ];
    };
}
