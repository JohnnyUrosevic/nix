{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      gonse = {
        enable = true;
        package = pkgs.paperServers.paper-26_2;

        serverProperties = {
          gamemode = "survival";
          difficulty = "hard";
          motd = "Gonse's Minecraft server!";
          white-list = true;
          max-players = 50;
        };

        operators = {
          themagicalcake = "9e7dff38-a6fc-47bc-91c9-9fa4e4dc460d";
        };

        symlinks = {
          "plugins" = pkgs.linkFarm "plugins" {
            "PasswordWhitelist.jar" = pkgs.fetchurl {
              url = "https://hangarcdn.papermc.io/plugins/Strokkur424/PasswordWhitelist/versions/v1.0.0/PAPER/PasswordWhitelist-1.0.0.jar";
              hash = "sha256-2/eK9AzUKWMigWrhBZ+KYBP/tLUlROCTt7Q84kpQm5E=";
            };
            "PasswordWhitelist" = ./plugins/PasswordWhitelist;
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    25565
    19132
  ];
}
