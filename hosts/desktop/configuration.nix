{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ../../features
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";

  networking.networkmanager = {
    enable = true;
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

  #TODO move this to ssh.nix
  programs.ssh.startAgent = true;
  services.openssh.enable = true;
  environment.enableAllTerminfo = true;

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv4.ip_forward" = 1;
  };

  networking.enableIPv6 = false;


  #TODO: move this to home.nix after I start using nix to configure zshrc
  programs.zsh.shellAliases = {
    build = "sudo nixos-rebuild switch --impure --flake=/home/goose/nix/";
  };

  system.stateVersion = "25.11";

}
