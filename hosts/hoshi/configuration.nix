{ config, pkgs, ... }:
{
  imports = [
    ../../users/will.nix
  ];

  virtualisation = {
    forwardPorts = [ 
      { from = "host"; host.port = 2222; guest.port = 22; }
    ];

    memorySize = 8192;
    cores = 2;
  };

  networking = {
    hostId = "3282a989";
    hostName = "hoshi";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {  
    enable = true;  
    ports = [ 22 ];
    settings = {
      AllowUsers = [ "will" ];
      PasswordAuthentication = false;
    };
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
  ];

  system.stateVersion = "24.11";
}
