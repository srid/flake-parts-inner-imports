{ self, config, lib, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib)
    mkPerSystemOption;
  inherit (lib)
    types;
in
{
  options = {
    perSystem = mkPerSystemOption
      ({ config, self', inputs', pkgs, system, ... }:
        let
          childSubmodule = types.submodule {
            options = {
              a = lib.mkOption {
                type = types.listOf types.int;
              };
            };
          };
        in
        {
          options.foo = lib.mkOption {
            type = types.attrsOf childSubmodule;
          };
        });
  };
}
