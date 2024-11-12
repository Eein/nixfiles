# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../users/will.nix
    ];

  # Cloudflare Warp
  systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically

  # Nix
  nix = {
    package = pkgs.nixFlakes;
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  systemd.services.ckb-next = {
    enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.extraHosts = 
    ''
    127.0.0.1    tiltifydev.com
    127.0.0.1    api.tiltifydev.com
    127.0.0.1    app.tiltifydev.com
    127.0.0.1    dashboard.tiltifydev.com
    127.0.0.1    causeapi.tiltifydev.com
    127.0.0.1    causes.tiltifydev.com
    127.0.0.1    userapi.tiltifydev.com
    127.0.0.1    overlays.tiltifydev.com
    127.0.0.1    donate.tiltifydev.com
    127.0.0.1    twitch-ext.tiltifydev.com
    127.0.0.1    id.tiltifydev.com
    127.0.0.1    site-search.tiltifydev.com
    ${builtins.readFile ./secret-hosts.txt}
    '';
    

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Phoenix";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.tailscale.enable = true;
  services.openssh.ports = [ 22 443 2222 7422 ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      variant = "";
      layout = "us";
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.canon-cups-ufr2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # rtkit
  security.rtkit.enable = true;
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraRules = [
    { groups = [ "wheel" ]; commands = [ "ALL" ]; }
    ];
  };

  # 32 bit vulkan drivers
  hardware.opengl.driSupport32Bit = true; 

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.ckb-next.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.nodejs_22
    pkgs.nodePackages.pnpm
    pkgs.typescript

    pkgs.cloudflare-warp
    pkgs.gnomeExtensions.cloudflare-warp-toggle
    pkgs.vim 
    pkgs.wget
    pkgs.ckb-next
    pkgs.xwaylandvideobridge
    pkgs.devenv
    pkgs.dotnetCorePackages.dotnet_8.sdk
    pkgs.dotnetCorePackages.dotnet_8.runtime
    pkgs.dotnetCorePackages.dotnet_8.aspnetcore
    pkgs.avalonia-ilspy
    (pkgs.jetbrains.rider.overrideAttrs {
      version = "2024.2.7";
      src = builtins.fetchurl {
        url = "https://download.jetbrains.com/rider/JetBrains.Rider-2024.2.7.tar.gz";
        sha256 = "0hkypbxrrp0b4rffjawfr7flagyy1zvqzsnrq21bkvmjz6gs9pbi";
      };
      extraPkgs = [ pkgs.icu ];
    })

  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
  # Exclude junk gnome packages we dont use
  environment.gnome.excludePackages = with pkgs.gnome; [
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

  programs.fish = {
    enable = true;
  };

  programs.steam.enable = true;
  fonts.fontconfig.enable = true;
  virtualisation.docker.enable = true; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-curses;
     enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
