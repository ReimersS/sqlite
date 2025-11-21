{
  description = "A flake for sqlite";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
  let
    pkgs = import nixpkgs { inherit system; };
    musl-pkgs = import nixpkgs { inherit system; crossSystem = { config = "${system}-musl"; }; };
  in {

    packages.default = musl-pkgs.stdenv.mkDerivation {
    	name = "sqlite3-static";
	src = self;

	buildInputs = with pkgs; [
          gnumake
	];
    };
  });
}
