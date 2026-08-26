{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    neovim
    ripgrep
    gcc
    nodejs
    nixd
    nixpkgs-fmt

    cowsay
    fortune-kind
    zoxide

    lazygit
    bat
    fd
    skim

    ffmpeg

    sops

    tmux
  ];
}
