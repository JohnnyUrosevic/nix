{
  description = "Nixos Home Server";
  inputs = {
    self.submodules = true;

    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      nix-darwin,
      ...
    }@inputs:
    {
      nixosConfigurations.gooselab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/gooselab/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.goose = import ./hosts/gooselab/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.goose = import ./hosts/desktop/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };

      darwinConfigurations."Johnnys-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.goose = import ./hosts/macbook/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
