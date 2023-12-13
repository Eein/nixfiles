{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "will";
  home.homeDirectory = "/home/will";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Sky-dark";
    QT_STYLE_OVERRIDE = "Catppuccin-Mocha-Standard-Sky-dark";
  };

  programs.git = {
    enable = true;
    userName = "William Volin";
    userEmail = "me@williamvolin.com";
    signing = {
      signByDefault = true;
      key = null;
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = {                          
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
  programs.htop.enable = true;
  programs.lf = {
    enable = true;
    keybindings = {
      "<enter>" = "open";
      "sh" = "shell";
    };
  };
  programs.ripgrep.enable = true;
  programs.vim.enable = true;

  imports = [
    ./editor/neovim.nix
    ./terminal/tmux.nix
    ./terminal/alacritty.nix
  ];

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  home.packages = [
    pkgs.discord
    pkgs.docker-compose
    # Eventually move this to home-manager profiles
    # and automatically install extensions
    (pkgs.firefox.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    })
    pkgs.gcc
    pkgs.gnome-browser-connector
    pkgs.gnome.gnome-keyring
    pkgs.gnome.gnome-tweaks
    pkgs.magic-wormhole
    pkgs.pinentry
    pkgs.spotify
    pkgs.unzip
    pkgs.xclip
    pkgs.pavucontrol
    pkgs.megasync
    pkgs.pciutils
    pkgs.thunderbird
    pkgs.killall

    # Games
    pkgs.xivlauncher
    pkgs.bottles
    pkgs.wine

    # LSP
    pkgs.nil

    # Gnome Stuff
    pkgs.gnomeExtensions.user-themes
    (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Sky-dark";
      package = (pkgs.catppuccin-gtk.override {
          accents = [ "sky" ]; # You can specify multiple accents here to output multiple themes
          size = "standard";
          tweaks = [ "normal" ]; # You can also specify multiple tweaks here
          variant = "mocha";
      });
    };
  };

  # dconf settings to make legacy applications respect dark mode
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "org/gnome/mutter" = {
        edge-tiling = true;
      };

      "org/gnome/desktop/interface" = {
        gtk-theme = "Catppuccin-Mocha-Standard-Sky-dark";
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      "org/gnome/shell/extensions/user-theme" = {
        name= "Catppuccin-Mocha-Standard-Sky-dark";
      };
    };
  };
}
