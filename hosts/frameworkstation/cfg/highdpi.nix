{ ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # QT
  environment.sessionVariables.QT_ENABLE_HIGHDPI_SCALING = "1";
  environment.sessionVariables.QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  environment.sessionVariables.QT_SCALE_FACTOR = "1";
}
