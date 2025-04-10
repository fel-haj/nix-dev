{
  description = "Nix flake development environment for Terraform";


  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            terraform

            # Other HashiCorp packages if needed
            # packer
            # tflint
            # nomad
            # vault
            # nomad-autoscaler
            # nomad-pack
            # levant
            # damon
            # terragrunt
          ];
        };
      });
    };
}
