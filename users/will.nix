{pkgs, ...}:

{
  services.sshd.enable = true;
  users.groups.will = {};
  users.users.will = {
    isNormalUser = true;
    description = "will";
    group = "will";
    extraGroups = [ "warp" "dialout" "networkmanager" "wheel" "docker" "input" "cdrom" "scanner" "lp" ];
    shell = pkgs.fish;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIHe11OUfLKsm6xME7aNEKmWI6P+vH1ukjZzERlC641rIdovsi0Wx9YRBu0WTCEXmtOAJgYj3g2wPplcrKsPLNDz/BW3SDakTABNznELc4RCsHuer9OJc8Hy5A9rnviax+EcQ00Bofdrn419m7NDRTx2NA1jOBLQ7R554GVO4jQ/xgZ/IBtNwkoijSTzrCt9yKBsSckGAUuKuDJKE/ZG1baDuHCrXUvSc3L42LW+afeZGdW0JJOCKgStBDCPWqCfxuSckmfBbWh6E8fQrBXdv9T88ykJR8iprWDdiJV/CjygcQc1sxqGGnRITOO8ruK4Sq467nmARgehSIoNEgHfXeJEhtjmQDuZ4VR9za3U7fNtaHnFKT9vuIy/xwqawm0rEEsXeze9T8bQwYWnLAYU/qoqLc/rk6r0Ih//SIrrbfXGQfBjTKkYTwVz4yeoLQ/X9Ub1F9IBN7htGu/UIlo36TvlrCbrxfWuMLxiKYtz8/TfgMqZlJcFBEFRMmW3xS6PQBvmusxJlwkPkRvYVhMS7Iv3FCGwd1l68swLbKrt8GeFARfa0wVgZY6bRnLhcNtSqSrXg18sQ1ig8XrkMj8D9qdnRwlEe6wB9+W6/SyhBZjplVf7wPDz9MEpbXd16l1T+Z+67d1VH8zl46YfvODYnsiikyQmDIg0SqE8r4lWkWZw== me@williamvolin.com"
    ];
  };
}
