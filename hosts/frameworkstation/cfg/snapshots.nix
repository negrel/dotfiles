{ pkgs, ... }:

{
  # Snapshot /home to /snapshots
  systemd.timers."home-snapshot" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "home-snapshot.service";
    };
  };
  systemd.services."home-snapshot" = {
    script = ''
      set -euo pipefail
      ${pkgs.btrfs-progs}/bin/btrfs subvolume snapshot -r \
        /home "/snapshots/home_snapshot_$(${pkgs.coreutils}/bin/date --rfc-3339=date | tr '-' '_')"

      # Keep only 3 latests snapshots.
      ${pkgs.coreutils}/bin/ls /snapshots | ${pkgs.coreutils}/bin/head -n -3 \
      | ${pkgs.findutils}/bin/xargs -I{} ${pkgs.btrfs-progs}/bin/btrfs subvolume delete /snapshots/{}
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
