{ pkgs, ... }: 
{
  home.packages = [
    pkgs.gnome-browser-connector
    pkgs.gnome-keyring
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.cloudflare-warp-indicator
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
  # gtk = {
  #   enable = true;
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = 1;
  #   };

  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = 1;
  #   };
  #   theme = {
  #     name = "Catppuccin-Mocha-Standard-Sky-Dark";
  #     package = (pkgs.catppuccin-gtk.override {
  #         accents = [ "sky" ]; # You can specify multiple accents here to output multiple themes
  #         size = "standard";
  #         tweaks = [ "normal" ]; # You can also specify multiple tweaks here
  #         variant = "mocha";
  #     });
  #   };
  # };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
      configPackages = with pkgs; [ xdg-desktop-portal-gnome ];
    };
    desktopEntries.Alacritty = {
      type = "Application";
      exec = "env WAYLAND_DISPLAY= alacritty";
      icon = "Alacritty";
      terminal = false;
      categories = ["System" "TerminalEmulator"];
      name = "Alacritty";
      genericName = "Alacritty";
      comment = "A fast, cross-platform, OpenGL terminal emulator";
      startupNotify = true;
      actions = {
        "New" = {
          name = "New Terminal";
          exec = "env WAYLAND_DISPLAY= alacritty";
        };
      };
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
        experimental-features = ["variable-refresh-rate"];
      };

      "org/gnome/desktop/interface" = {
     	  gtk-theme = "Adwaita-dark";
        # gtk-theme = "Catppuccin-Mocha-Standard-Sky-Dark";
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        enable-hot-corners = false;
      };

      "org/gnome/shell/extensions/user-theme" = {
        name= "Catppuccin-Mocha-Standard-Sky-Dark";
      };
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    geary       # email client
    seahorse    # password manager

    # these should be self explanatory
    gnome-calendar 
    gnome-characters 
    gnome-clocks 
    gnome-contacts
    gnome-logs 
    gnome-maps 
    gnome-music 
    gnome-weather 
    pkgs.gnome-connections
  ];

}
