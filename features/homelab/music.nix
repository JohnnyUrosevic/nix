{
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/mnt/data/audio";
      Address = "0.0.0.0";
    };
    openFirewall = true;
  };
}
