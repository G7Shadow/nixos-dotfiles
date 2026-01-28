{inputs, ...}: {
  systems = ["x86_64-linux"];
  
  flake.nixosConfigurations.Omega = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    
    modules = [
      ../modules/system/configuration.nix
      
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = {inherit inputs;};
          users.jeremyl = import ../modules/home/home.nix;
        };
      }
      
      inputs.nix-index-database.nixosModules.nix-index
      {
        programs.nix-index-database.comma.enable = true;
      }
    ];
  };
}
