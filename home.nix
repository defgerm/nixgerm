{ config, pkgs, ... }:

{
  home.username = "jester";
  home.homeDirectory = "/home/jester";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wget
    neovim
    htop
    btop
    yazi
    claude-code
    chromium
    fastfetch
    kitty
    rofi
    swww
    dunst
    waybar
    nautilus
    brightnessctl
    playerctl
    # neovim deps
    gcc
    ripgrep
    fd
    nodejs
    lua-language-server
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  programs.bash.initExtra = ''
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  '';

  programs.bash.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
      exec start-hyprland
    fi
  '';
}
