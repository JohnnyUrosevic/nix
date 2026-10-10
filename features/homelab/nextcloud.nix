{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/nextcloud 0775 nextcloud nextcloud - -"
  ];

  services.postgresql = {
    enable = true;
  };

  fileSystems."${config.services.nextcloud.home}/data" = {
    device = "/mnt/data/cloud";
    fsType = "none";
    options = [
      "bind"
    ];
  };

  services.nextcloud = {
    enable = true;
    hostName = "nix-nextcloud";
    config = {
      adminpassFile = "/run/secrets/nextcloud/password";
      dbtype = "pgsql";
    };
    database.createLocally = true;
    configureRedis = true;
    package = pkgs.nextcloud33;
    https = true;
    settings.overwriteprotocol = "https";

    maxUploadSize = "1024G";
    extraOptions = {
      max_chunk_size = "1073741824";
    };

    nginx.enableFastcgiRequestBuffering = false;

    phpOptions = {
      "upload_max_filesize" = "1024G";
      "post_max_size" = "1024G";
      "max_execution_time" = "3600";
    };

    settings.trusted_domains = [
      "localhost"
      "192.168.4.66"
      "cloud.gonse.org"
    ];

    settings.trusted_proxies = [
      "127.0.0.1"
      "::1"
      "192.168.1.0/24"
    ];
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    {
      addr = "127.0.0.1";
      port = 8009;
    }
  ];

  networking.firewall.allowedTCPPorts = [ 8009 ];
}
