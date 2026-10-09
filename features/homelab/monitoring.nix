{
  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = [ "systemd" ];   # filesystem + diskstats on by default
      port = 9100;
      openFirewall = true;
    };
    smartctl = {
      enable = true;
      devices = [ "/dev/sda" "/dev/sdb" "/dev/sdc" "/dev/sdd" "/dev/sde" "/dev/nvme0n1" ];
      port = 9633;
      openFirewall = true;
    };
  };
}
