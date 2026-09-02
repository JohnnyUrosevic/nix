{ pkgs, ... }:
let
  sharedAttrs = {
    enable = true;
    openFirewall = true;
  };
  gooseUser = {
    user = "goose";
  };
in
{
  services.radarr = sharedAttrs // gooseUser;
  services.sonarr = sharedAttrs // gooseUser;
  services.bazarr = sharedAttrs // gooseUser;

  services.prowlarr = sharedAttrs;

  services.jellyfin = sharedAttrs // gooseUser // {
    group = "video";
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  services.seerr = sharedAttrs;
}
