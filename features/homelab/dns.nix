{
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 54;

      upstreams.groups.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];

      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };

      customDNS.mapping = {
        "gonse.org" = "100.108.232.100";
      };

      blocking = {
        denylists = {
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 53 54 ];
  networking.firewall.allowedUDPPorts = [ 53 54 ];

  services.dnsmasq = {
    enable = true;
    settings = {
      port = 53;
      bind-interfaces = true;

      except-interface = "podman*";

      listen-address= "127.0.0.1,100.108.232.100";
      localise-queries = true;
      local-service = true;

      no-resolv = true;
      no-poll = true;

      server = [ "127.0.0.1#54" ];
      cache-size = 0;
    };
  };

  networking.nameservers = [ "127.0.0.1" ];

}
