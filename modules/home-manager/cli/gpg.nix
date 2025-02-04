{ pkgs, ... }: 
{
  programs.gnupg.agent = {
     enable = true;
    defaultCacheTtl = 1800;
     pinentryPackage = pkgs.pinentry-curses;
     enableSSHSupport = true;
  };
  programs.gpg.enable = true;
}
