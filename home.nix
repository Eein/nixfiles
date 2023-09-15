{ config, pkgs, ... }:

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

  programs.git = {
    enable = true;
    userName = "Eein";
    userEmail = "me@williamvolin.com";
  };


  services.gpg-agent = {                          
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.alacritty.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.htop.enable = true;
  programs.lf.enable = true;
  programs.neovim.enable = true;
  programs.ripgrep.enable = true;
  programs.tmux.enable = true;
  programs.vim.enable = true;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  home.packages = [
    pkgs.discord
    pkgs.gcc
    pkgs.gnome-browser-connector
    pkgs.gnome.gnome-keyring
    pkgs.gnome.gnome-themes-extra
    pkgs.pinentry
    pkgs.spotify
    pkgs.steam
    pkgs.xclip
  ];
}
