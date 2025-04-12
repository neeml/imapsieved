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
    outputHashes = {
      "imap-3.0.0-alpha.14" = "sha256-S5exYKExT6eg23Sj5c9KtuKQcZCYODOHvsv8CgHx5Zk=";
    };
    allowBuiltinFetchGit = false;
  };

  nativeBuildInputs = with pkgs; [ pkg-config protobuf ];
  buildInputs = with pkgs; [ systemd.dev ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/neeml/imapsieved";
    license = licenses.asl20;
  };
}
