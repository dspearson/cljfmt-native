{
  description = "cljfmt-native-image";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, clj-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cljpkgs = clj-nix.packages."${system}";
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.leiningen pkgs.graalvm-ce pkgs.clojure ];
        };
        packages = {
          cljfmt-jre = cljpkgs.mkCljBin {
            projectSrc = ./.;
            name = "cljfmt";
            main-ns = "cljfmt-graalvm.core";
            jdkRunner = pkgs.jdk17_headless;
          };
          cljfmt = cljpkgs.mkGraalBin {
            cljDrv = self.packages."${system}".cljfmt-jre;
          };
        };
      });
}
