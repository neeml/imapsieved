{ lib
, pkgs ? import <nixpkgs>
, rustPlatform
,
}:
rustPlatform.buildRustPackage rec {
  name = "imapsieved";

  src = lib.cleanSource ../../.;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = with pkgs; [ pkg-config protobuf ];
  buildInputs = with pkgs; [ systemd.dev ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/neeml/imapsieved";
    license = licenses.asl20;
  };
}
