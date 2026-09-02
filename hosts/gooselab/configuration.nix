{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../features
    ../../features/homelab
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gooselab"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.resolved.enable = true;
  networking.networkmanager = {
    enable = true;
    settings.main.rc-manager = "resolvconf";
    dns = "systemd-resolved";
  };

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.goose = {
    isNormalUser = true;
    description = "Johnny Urosevic";
    extraGroups = [
      "networkmanager"
      "wheel"
      "nextcloud"
      "video"
      "render"
    ];
    shell = pkgs.zsh;
  };

  users.users.yabo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fonts.enableDefaultPackages = true;

  programs.ssh.startAgent = true;
  services.openssh.enable = true;
  environment.enableAllTerminfo = true;

  services.openssh.extraConfig = ''
    UseDNS no
    GSSAPIAuthentication no
  '';

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv4.ip_forward" = 1;
  };

  networking.enableIPv6 = false;

  #TODO: move this to home.nix after I start using nix to configure zshrc
  programs.zsh.shellAliases = {
    build = "sudo nixos-rebuild switch --flake=path:/home/goose/nix/ --impure";
  };

  system.stateVersion = "25.11"; # Did you read the comment?

}
