{
  description = "I be Decapo, this be my flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          # inputs.home-manager.nixosModules.default
          {
            environment.systemPackages = with pkgs; [
              git
              vscodium
              sublime-merge
              gtkwave
              verilator
              python3
              wireshark
              gcc
              go
              cmake
              spotify
              slack
            ];
          }
          #./git.nix
        ];
      };
    };
}
