{}:

let

  rust_overlay = import (builtins.fetchTarball https://github.com/oxalica/rust-overlay/archive/master.tar.gz);

  pkgs = import <nixpkgs> { overlays = [ rust_overlay ]; };

  bootimage = pkgs.rustPlatform.buildRustPackage rec {
    pname = "bootimage";
    version = "v0.10.3";

    src = pkgs.fetchFromGitHub {
      owner = "rust-osdev";
      repo = pname;
      rev = version;
      sha256 = "12p18mk3l473is3ydv3zmn6s7ck8wgjwavllimcpja3yjilxm3zg";
    };

    cargoSha256 = "06l9d1bm0v2kr91fsnmaad3va24j52c00xyw64ybf3wfznmn3a3v";
  };

in

pkgs.mkShell {
  buildInputs = with pkgs; [
    (rust-bin.nightly.latest.default.override {
      extensions = [ "rust-src" "llvm-tools-preview" ];
      targets = [ "thumbv7em-none-eabihf" ];
    })
    bootimage
    rust-analyzer
    bashInteractive
    qemu
  ];
}
