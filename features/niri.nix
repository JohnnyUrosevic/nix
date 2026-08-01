{ config, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "goose";
      };
    };
  };

  systemd.user.services.niri.enableDefaultPath = false;
}
