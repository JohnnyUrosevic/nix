{
  lib,
  ...
}:

{
  services.shelfmark = {
    enable = true;
    openFirewall = true;
    environment = {
      FLASK_HOST = "0.0.0.0";
    };
  };

  systemd.services.shelfmark = {
    serviceConfig = {
      ReadWritePaths = [
        "/mnt/data/downloads"
        "/var/lib/sabnzbd/complete"
        "/mnt/data/books"
        "/mnt/data/audiobooks"
      ];
      UMask = lib.mkForce "0022"; 
    };
  };

  services.kavita = {
    enable = true;
    tokenKeyFile = /run/secrets/kavita/tokenKey;
  };

  services.audiobookshelf = {
    enable = true;
    port = 5001;
    openFirewall = true;
    user = "goose";
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];
  networking.firewall.allowedUDPPorts = [ 5000 ];
}
