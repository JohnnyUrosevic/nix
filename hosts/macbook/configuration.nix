{ pkgs, ... }:

{
  imports = [
    ../../features
    ../../features/1password.nix
    ./homebrew.nix
  ];

  users.users.goose = {
    description = "Johnny Urosevic";
    home = "/Users/goose";
    shell = pkgs.zsh;
    uid = 501;
  };
  system.primaryUser = "goose";

  networking.localHostName = "Johnnys-MacBook-Air";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "America/Los_Angeles";

  security.pam.services.sudo_local.touchIdAuth = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  system.defaults.finder.NewWindowTarget = "Home";
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder._FXSortFoldersFirst = true;
  system.defaults.finder.QuitMenuItem = true;

  system.stateVersion = 7;
}
