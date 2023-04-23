{ lib, ... }:
rec {
  # Same as attrValues but returns keys instead of values of an attribute set
  attrNames = (attrs: lib.mapAttrsToList (name: value: name) attrs);

  # Returns true if attribute set or list is empty
  isEmpty = (a:
    if builtins.isAttrs a
    then (builtins.length (lib.attrValues a) == 0)
    else (builtins.length a) == 0
  );

  attrsToList =
    (attrs:
      lib.mapAttrsToList
        (name: value:
          { inherit name value; }
        )
        attrs
    );

  # Convert attribute set to a list
  attrsToListRecursive =
    (attrs: lib.mapAttrsToList
      (name: value: {
        name = name;
        value = (if builtins.isAttrs value then attrsToListRecursive value else value);
      })
      attrs);

  # Convert list to attribute set
  listToAttrsRecursive =
    (list: lib.fold
      (el: acc: acc // {
        "${el.name}" =
          if builtins.isList el.value
          then listToAttrsRecursive el.value
          else el.value;
      })
      { }
      list
    );

  # Recursively list regular files under the given directory.
  # Result is returned as an attribute set.
  listRegularFiles =
    (dir: lib.mapAttrs
      (key: value:
        if value == "directory"
        then
          listRegularFiles (dir + "/${key}")
        else
          value)
      (builtins.readDir dir));

  # Recursively list nix files under the given directory
  # Result is returned as an attribute set.
  listNixFiles =
    (dir:
      # This function can probably be optimised using one fold instead
      # of two filterAttrsRecursive.
      let result = lib.filterAttrsRecursive
        (key: value:
          if builtins.isAttrs value
          then true
          else lib.hasSuffix ".nix" key)
        (listRegularFiles dir);
      in
      lib.filterAttrsRecursive
        (key: value:
          if builtins.isAttrs value
          then ! isEmpty value
          else true
        )
        result
    );

  mapAttrsName = (f: set:
    lib.listToAttrs (builtins.map (attrs: { name = f attrs set.${attrs}; value = set.${attrs}; }) (lib.attrNames set)));

  mapAttrsNameRecursive = (f: set:
    let
      recurse = (attrs:
        let
          list = attrsToList attrs;
          mappedList =
            lib.fold
              (v: acc: acc ++ [{
                name = f v.name v.value;
                value =
                  if builtins.isAttrs v.value
                  then recurse v.value
                  else v.value;
              }])
              [ ]
              list;
        in
        lib.listToAttrs mappedList
      );
    in
    recurse set
  );

  # Recursively call pkgs.callPackage for each file under the given directory.
  callPackagesRecursively =
    (dir: { pkgs, ... }@inputs:
      # Recursive function that callPackage recursively
      let recurse = callInputs: dir: files:
        lib.mapAttrs
          (name: value:
            if
              builtins.isAttrs
                value
            then
              let
                recursiveValue = lib.recurseIntoAttrs (recurse callInputs (dir + "/${name}") value);
              in
              # default.nix are merged into parent attribute set
              if lib.hasAttrByPath [ "default" ] value
              then recursiveValue // (pkgs.callPackage (dir + "/${name}/default.nix") callInputs)
              else recursiveValue
            else
              pkgs.callPackage
                (dir + "/${name}.nix")
                callInputs
          )
          files;
      in
      lib.fixedPoints.fix (self:
        let
          # inputs of callPackage with fixed points so packages can depend 
          # on each other.
          callInputs = lib.recursiveUpdate inputs { pkgs = self; };
          # Remove .nix extension
          files =
            mapAttrsNameRecursive
              (name: value: lib.removeSuffix ".nix" name)
              (listNixFiles dir);
        in
        (recurse callInputs dir files))
    );
}
