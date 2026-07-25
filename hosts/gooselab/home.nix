{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/gooselab/dotfiles/.config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    tmux = "tmux";
  };
in

{
  home.username = "goose";
  home.homeDirectory = "/home/goose";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  home.file.".zshrc".source = ../../dotfiles/.zshrc;
  home.file.".alias".source = ../../dotfiles/.alias;
  home.file.".vimrc".source = ../../dotfiles/.vimrc;
  home.file.".gitconfig".source = ../../dotfiles/.gitconfig;
  home.file.".p10k.zsh".source = ../../dotfiles/.p10k.zsh;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
