{ pkgs, ... }: {
  home.packages = [ 
    pkgs.nil
    pkgs.ruff
    pkgs.ruff-lsp
  ];
}
