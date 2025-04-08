{
  description = "Nix flake development environment for Python";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
      # Write version in way of Nix-packages (313 instead of 3.13)
      version = "313";
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }:
        let
          python = pkgs."python${version}";
        in
        {
          default = pkgs.mkShellNoCC {
            # If Python version of .venv != version above (e.g. 313), delete .venv and reload
            venvDir = ".venv";

            packages = [
              python.pkgs.venvShellHook
              python.pkgs.pip

              # Add whatever else might be needed here:
              # pkgs.basedpyright

              # pkgs.ruff
              # or
              # python.ruff
            ];
          };
        });
    };
}
