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
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
