{ lib, ... }:

let
  publicServices = {
    "watch" = 8096;
    "request" = 5055;
    "cloud" = 8009;
    "read" = 5000;
    "listen" = 5001;
    "photos" = 2283;
  };
  privateServices = {
    "radarr" = 7878;
    "sonarr" = 8989;
    "prowlarr" = 9696;
    "bazarr" = 6767;
    "torrent" = 7979;
    "usenet" = 8080;
    "library" = 8084;
  };
in
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;

    virtualHosts = lib.mapAttrs' (subdomain: port: {
      name = "${subdomain}.gonse.org";
      value = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:${toString port}
        '';
      };
    }) publicServices //
    lib.mapAttrs' (subdomain: port: {
      name = "${subdomain}.gonse.org";
      value = {
        extraConfig = ''
          @notAllowed not remote_ip {$PUBLIC_IP} 100.64.0.0/10 private_ranges
          abort @notAllowed

          reverse_proxy http://127.0.0.1:${toString port}
        '';
      };
    }) privateServices;
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = [ "/run/secrets/caddy/environment" ];
}
