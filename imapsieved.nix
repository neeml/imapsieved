{ lib
, pkgs ? import <nixpkgs>
, rustPlatform
,
}:
rustPlatform.buildRustPackage {
  name = "imapsieved";

  src = lib.cleanSource ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "imap-3.0.0-alpha.14" = "";
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
