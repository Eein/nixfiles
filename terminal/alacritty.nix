{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "CaskaydiaCove Nerd Font";
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        title = "Alacritty";
        dynamic_title = false;
      };
    };
  };
}
