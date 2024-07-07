#
# Extend the Nginx module to support Authelia
#
# Options added:
# - enableAuthelia: This will enable the /authelia location block. To enable it just set enableAuthelia = true;
#
{
  config,
  lib,
  ...
}: let
  authelia = config.services.authelia.instances.main;
  autheliaUrl = "http://${authelia.settings.server.host}:${builtins.toString authelia.settings.server.port}";

  vhostOptions = {config, ...}: {
    options = {
      enableAuthelia = lib.mkEnableOption "Enable authelia location";
    };
    config = lib.mkIf config.enableAuthelia {
      locations."/authelia".extraConfig = ''
        internal;
        set $upstream_authelia ${autheliaUrl}/api/verify; #ADD YOUR IP AND PORT OF AUTHELIA
        proxy_pass_request_body off;
        proxy_pass $upstream_authelia;
        proxy_set_header Content-Length "";

        # Timeout if the real server is dead
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;
        client_body_buffer_size 128k;
        proxy_set_header Host $host;
        proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header X-Forwarded-Uri $request_uri;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_redirect  http://  $scheme://;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_cache_bypass $cookie_session;
        proxy_no_cache $cookie_session;
        proxy_buffers 4 32k;

        send_timeout 5m;
        proxy_read_timeout 240;
        proxy_send_timeout 240;
        proxy_connect_timeout 240;
      '';
    };
  };
in {
  options.services.nginx.virtualHosts = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule vhostOptions);
  };
}
