{ config, pkgs, ... }:

{
  home.username = "jester";
  home.homeDirectory = "/home/jester";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wget
    htop
    btop
    yazi
    claude-code
    chromium
    fastfetch
    kitty
    swww
    dunst
    waybar
    nautilus
    brightnessctl
    nitch
    impala
    playerctl
    hyprlock
    hypridle
    obsidian
    # neovim deps
    gcc
    ripgrep
    fd
    nodejs
    lua-language-server
  ];

  xdg.configFile = {
    "hypr/hyprland.lua".source  = ./dotfiles/hypr/hyprland.lua;
    "hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
    "hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;
    "kitty/kitty.conf".source            = ./dotfiles/kitty/kitty.conf;
    "kitty/GruvBox_DarkHard.conf".source = ./dotfiles/kitty/GruvBox_DarkHard.conf;
    "nvim/init.lua".source                   = ./dotfiles/nvim/init.lua;
    "nvim/lua/config/lazy.lua".source        = ./dotfiles/nvim/lua/config/lazy.lua;
    "nvim/lua/plugins/lsp.lua".source              = ./dotfiles/nvim/lua/plugins/lsp.lua;
    "nvim/lua/plugins/treesitter.lua".source       = ./dotfiles/nvim/lua/plugins/treesitter.lua;
    "starship.toml".source                        = ./dotfiles/starship/starship.toml;
  };

programs.starship = {
  enable = true;
  enableBashIntegration = true; # Automatically hooks into your Bash shell
};

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };

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
  '';

  programs.bash.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
      exec start-hyprland
    fi
  '';
}
