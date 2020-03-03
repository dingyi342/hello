{ compiler ? "ruby_2_7"

, rev    ? "1fe82110febdf005d97b2927610ee854a38a8f26"
, sha256 ? "08x6saa7iljyq2m0j6p9phy0v17r3p8l7vklv7y7gvhdc7a85ppi"

, pkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256; }) {
    config.allowUnfree = true;
    config.allowBroken = false;
    overlays = [
      (self: super: {})
    ];
  }
}:

pkgs.stdenv.mkDerivation rec {
  name = "${compiler}-hello-${version}";
  version = "1.0.0";

  buildInputs = [ pkgs.${compiler} ];

  src = ./.;

  buildPhase = ''
    touch hello
  '';

  doCheck = true;
  checkPhase = ''
    cmp -b <(./hello) <(echo "Hello, world!")
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hello $out/bin
  '';
}
