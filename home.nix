{ config, inputs, pkgs, ... }:
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

  # home.sessionVariables = {
  #   GTK_THEME = "Catppuccin-Mocha-Standard-Sky-Dark";
  #   QT_STYLE_OVERRIDE = "Catppuccin-Mocha-Standard-Sky-Dark";
  # };

  programs.home-manager.enable = true;

  imports = [
    ./modules/home-manager/cli/lf.nix
    ./modules/home-manager/cli/bat.nix
    ./modules/home-manager/cli/eza.nix
    ./modules/home-manager/cli/git.nix
    ./modules/home-manager/cli/fish.nix
    ./modules/home-manager/cli/tmux.nix
    ./modules/home-manager/cli/bottom.nix
    ./modules/home-manager/cli/ripgrep.nix
    ./modules/home-manager/cli/direnv.nix
    ./modules/home-manager/cli/gpg.nix
    ./modules/home-manager/cli
    ./modules/home-manager/lsp
    ./modules/home-manager/fonts/cascadiacove.nix
    ./modules/home-manager/fonts/fontconfig.nix
    ./modules/home-manager/infra/k9s.nix
    ./modules/home-manager/infra/kube.nix
    ./modules/home-manager/infra/docker.nix
    ./modules/home-manager/infra/azurecli.nix
    ./modules/home-manager/music/spotify.nix
    ./modules/home-manager/tools/firefox.nix
    ./modules/home-manager/tools/bottles.nix
    ./modules/home-manager/tools/flatpak.nix
    ./modules/home-manager/tools/megasync.nix
    ./modules/home-manager/editor/neovim.nix
    ./modules/home-manager/settings/gnome.nix
    ./modules/home-manager/gaming/steam.nix
    ./modules/home-manager/terminal/ghostty.nix
    ./modules/home-manager/communication/teams.nix
    ./modules/home-manager/communication/discord.nix
    ./modules/home-manager/communication/discord.nix
  ];
}
