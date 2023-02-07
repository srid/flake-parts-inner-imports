{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      imports = [ ./flake-module.nix ];
      perSystem = { self', config, pkgs, ... }: {
        foo.whatever = {
          imports =
            let defaults = { a = [ 24 ]; };
            in [ defaults ];
          a = [ 42 ];
        };

        apps.default = {
          type = "app";
          program = pkgs.writeShellApplication {
            name = "hello";
            text = ''
              echo "foo.whatever.a =" ${builtins.toString config.foo.whatever.a}
            '';
          };
        };
      };
    };
}
