{
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/goose/.config/sops/age/keys.txt";

  sops.secrets."openvpn/password" = { };
  sops.secrets."nextcloud/password" = { };
  sops.secrets."kavita/tokenKey" = { };
  sops.secrets."caddy/environment" = { };
  sops.secrets."soulseek/environment" = { };
}
