{
  pkgs,
  inputs,
  lib,
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
          difficulty = "medium";
          motd = "Gonse's Minecraft server!";
          white-list = false;
          max-players = 50;
        };

        operators = {
          themagicalcake = "9e7dff38-a6fc-47bc-91c9-9fa4e4dc460d";
        };

        files = {
          "plugins/PasswordWhitelist.jar" = pkgs.fetchurl {
            url = "https://hangarcdn.papermc.io/plugins/Strokkur424/PasswordWhitelist/versions/v1.0.0/PAPER/PasswordWhitelist-1.0.0.jar";
            hash = "sha256-2/eK9AzUKWMigWrhBZ+KYBP/tLUlROCTt7Q84kpQm5E=";
          };
          "plugins/PasswordWhitelist/data" = ./plugins/PasswordWhitelist/data;
          "plugins/Geyser-Spigot.jar" = pkgs.fetchurl {
            url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot";
            hash = "sha256-t1S7JXl2VJVTI5voLEsajKl7rJl8h5n97loooofn/aY=";
          };
          "plugins/floodgate-spigot.jar" = pkgs.fetchurl {
            url = "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot";
            hash = "sha256-n0NsQv/YsQkaQ316Thb4IYG51TFPixcy36nVpP/7Gf4=";
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    25565
    19132
  ];

  networking.firewall.allowedUDPPorts = [
    19132
  ];

  # Nix rebuilds will often restart the server without changes in here. If you update this you have to restart the server manually
  systemd.services.minecraft-server-gonse = {
    restartIfChanged = lib.mkForce false;
  };
}
