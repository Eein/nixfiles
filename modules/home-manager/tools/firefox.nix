{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      nativeMessagingHosts = [
        # Gnome shell native connector
        pkgs.gnome-browser-connector
      ];
    };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
           "media.hardware-video-decoding.enabled" = true;
           "media.hardware-video-decoding.force-enabled" = true;
        };
      };
    };
  };
}
