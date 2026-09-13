{ ... }:

{
  users.users.anegrel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    initialPassword = "anegrel";
  };
}
