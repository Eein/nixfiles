{ pkgs, ... }: {
  home.packages = [ 
  (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];
}
