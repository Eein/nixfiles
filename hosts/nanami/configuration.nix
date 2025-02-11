# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  networking.hostName = "nanami"; # Define your hostname.
# this needs to be fixed

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    package = pkgs.ollama-cuda;
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = false;
    powerManagement.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    dynamicBoost.enable = false;
    nvidiaSettings = true;
    prime = {
      amdgpuBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

# boot.extraModprobeConfig = ''
#   blacklist nouveau
#   options nouveau modeset=0
# '';

# services.udev.extraRules = ''
#   # Remove NVIDIA USB xHCI Host Controller devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA USB Type-C UCSI devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA Audio devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA VGA/3D controller devices
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
# '';
# boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
# services.xserver.videoDrivers = [ "amdgpu" ];
}
