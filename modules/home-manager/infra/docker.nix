{ pkgs, ... }: {
  virtualisation.docker.enable = true; 
  home.packages = [ 
    pkgs.docker-compose
  ];
}
