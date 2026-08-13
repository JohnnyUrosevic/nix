{
  homebrew.enable = true;
  homebrew.casks = [
    "ghostty"
    "tailscale-app"
    "discord"
    "steam"
    "zen"
    "google-chrome"
    "rustdesk"
    "raycast"
    "spotify"
    "obsidian"
    "godot"
    "iina"

    {
      name = "private-internet-access";
      trusted = true;
    }
  ];

}
