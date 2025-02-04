{ ... }:
{
  programs.git = {
    enable = true;
    userName = "William Volin";
    userEmail = "me@williamvolin.com";
    signing = {
      signByDefault = true;
      key = null;
    };
  };

}
