{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, ... } @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = inputs.nixpkgs.outputs.legacyPackages.${system};
        in
        {
          packages = {
            imapsieved = pkgs.callPackage ./imapsieved.nix { };
            default = self.outputs.packages.${system}.imapsieved;
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
