{
  description = "My Nixos Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nix-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.Alpha = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jeremyl = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
