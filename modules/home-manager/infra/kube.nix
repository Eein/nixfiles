{ pkgs, ... }: {
  home.packages = [ 
    pkgs.kubectl
    pkgs.kubelogin
  ];
}
