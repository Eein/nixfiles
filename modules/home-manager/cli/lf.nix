{ ... }:
{
  programs.lf = {
    enable = true;
    commands = {
      touch = ''%touch $1'';
    };
    keybindings = {
      "<enter>" = "open";
      "sh" = "shell";
    };
  };
}
