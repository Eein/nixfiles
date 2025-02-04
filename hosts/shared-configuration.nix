# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ghostty, ... }:

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
    package = pkgs.lix;
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
  services.openssh.ports = [ 22 443 ];

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
  hardware.graphics.enable32Bit = true;

  hardware.pulseaudio.enable = false;
  # Enable sound with pipewire.
  hardware.ckb-next.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
  ];

  # Exclude junk gnome packages we dont use
  programs.fish = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    silent = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 2222 ];
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
