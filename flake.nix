{
  description = "Naiveté Compass of Mood - HTML preview with live-server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        apps.default = {
          type = "app";
          program = "${pkgs.writeShellScript "live-server-9000" ''
            ${pkgs.nodePackages.live-server}/bin/live-server --port=9000
          ''}";
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodePackages.live-server
          ];
        };
      };
    };
}