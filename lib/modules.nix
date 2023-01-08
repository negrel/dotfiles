{ lib, ... }:

with lib;
{
  mapModules = (dir:
    builtins.readDir dir
  );
}
