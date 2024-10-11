#
# MediaWiki configuration
#
# This module configures MediaWiki, a free and open-source wiki software.
#
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault mkForce;

  domain = "wiki.xilain.dev";
  sys = config.modules.system;
  cfg = sys.services;

  inherit (cfg.mediawiki.settings) port host;
in {
  config = mkIf config.services.mediawiki.enable {
    services.mediawiki = {
        webserver = "nginx";
        httpd.virtualHost.listen = [
            {
                ip = host;
                port = port;
                ssl = false;
            }
        ];
        # Administrator account username is admin.
        # Set initial password to "cardbotnine" for the account admin.
        passwordFile = pkgs.writeText "password" "cardbotnine";
        extraConfig = ''
            # Disable anonymous editing
            $wgGroupPermissions['*']['edit'] = false;
        '';

        extensions = {
            # some extensions are included and can enabled by passing null
            VisualEditor = null;

            # https://www.mediawiki.org/wiki/Extension:TemplateStyles
            TemplateStyles = pkgs.fetchzip {
            url = "https://extdist.wmflabs.org/dist/extensions/TemplateStyles-REL1_40-c639c7a.tar.gz";
            hash = "sha256-YBL0Cs4hDSNnoutNJSJBdLsv9zFWVkzo7m5osph8QiY=";
            };
        };

        nginx.virtualHosts.${domain} =
        {
          locations."/" = {
            proxyPass = "http://${host}:${toString port}";
          };
          quic = true;
        }
        // lib.sslTemplate;
    };
  };
}
