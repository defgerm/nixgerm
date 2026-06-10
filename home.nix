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
  };

  services.walker = {
    enable = true;
    systemd.enable = true;
    theme = {
      name = "catppuccin-mocha";
      style = ''
        * {
          all: unset;
          font-family: "SauceCodePro Nerd Font", monospace;
        }

        #walker {
          background: rgba(30, 30, 46, 0.95);
          border: 1px solid #313244;
          border-radius: 12px;
          padding: 8px;
          min-width: 500px;
        }

        #search {
          background: #181825;
          color: #cdd6f4;
          caret-color: #cba6f7;
          border-radius: 8px;
          padding: 10px 14px;
          margin-bottom: 8px;
          font-size: 16px;
          border: 1px solid #313244;
        }

        #search:focus {
          border-color: #cba6f7;
        }

        listview {
          background: transparent;
        }

        row {
          border-radius: 8px;
          padding: 6px 10px;
          margin: 1px 0;
        }

        row:selected {
          background: #313244;
        }

        row image {
          margin-right: 10px;
        }

        .name {
          color: #cdd6f4;
          font-size: 14px;
        }

        .description {
          color: #6c7086;
          font-size: 12px;
        }

        .activatable:hover {
          background: #313244;
          border-radius: 8px;
        }
      '';
    };
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
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  '';

  programs.bash.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
      exec start-hyprland
    fi
  '';
}
