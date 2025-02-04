{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      tmux = "tmux -L local";
      cat = "bat";
      top = "bottom";
      htop = "bottom";
      ls = "eza";
    };
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
