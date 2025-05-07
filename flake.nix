{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: let
    inherit (inputs) self;
    genPkgs = system:
      import inputs.nixpkgs {
        inherit system;
      };
  in
    inputs.flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = genPkgs system;
    in {
      packages = with pkgs; {
        imapsieved = callPackage ./build-aux/nix {inherit self;};
        default = self.packages.${system}.imapsieved;
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      };

      devShells.default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ./devenv.nix
        ];
      };
    })
    // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) imapsieved;
      };
    };
}
