{
  lib,
  self,
  pkgs,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  name = "imapsieved";

  src = lib.cleanSource self;

  cargoLock = {
    lockFile = "${finalAttrs.src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = with pkgs; [pkg-config protobuf];
  buildInputs = with pkgs; [systemd.dev openssl.dev];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/neeml/imapsieved";
    license = licenses.asl20;
  };
})
