{
  config,
  lib,
  inputs',
  ...
}: let
  inherit (lib) mkIf sslTemplate;

  sys = config.modules.system;
  cfg = sys.services;

  inherit (cfg.reposilite.settings) port;
in {
  imports = [
    ./reposilite-option.nix
  ];

  config = mkIf config.services.reposilite.enable {
    modules.system.services = {
      nginx.enable = true;
    };

    services.reposilite = {
      package = inputs'.nyxpkgs.packages.reposilite-bin;
      dataDir = "/var/lib/reposilite";

      openFirewall = true;

      user = "reposilite";
      group = "reposilite";

      settings = {
        inherit port;
      };
    };

    services.nginx.virtualHosts = {
      "repo.xilain.dev" =
        {
          locations."/".proxyPass = "http://127.0.0.1:${toString port}";
          extraConfig = ''
            access_log /var/log/nginx/reposilite-access.log;
            error_log /var/log/nginx/reposilite-error.log;
          '';
        }
        // sslTemplate;
    };
  };
}
