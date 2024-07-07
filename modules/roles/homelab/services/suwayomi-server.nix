{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.age) secrets;

  domain = "manga.xilain.dev";
  sys = config.modules.system;
  cfg = sys.services;

  inherit (cfg.suwayomi-server.settings) port host;
in {
  config = {
    modules.system.services = {
      nginx.enable = true;
    };

    services = {
      suwayomi-server = {
        enable = true;

        openFirewall = true;

        settings = {
          server = {
            ip = host;
            port = port;
            basicAuthEnabled = true;
            basicAuthUsername = "suwayomi";

            # NOTE: this is not a real upstream option
            basicAuthPasswordFile = secrets.suwayomi-server-password.path;
            autoDownloadNewChapters = false;
            maxSourcesInParallel = 6;
            extensionRepos = [
              "https://raw.githubusercontent.com/ThePBone/tachiyomi-extensions-revived/repo/index.min.json"
              "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
            ];
            settings = {
              server.webUIEnabled = true;
              server.initialOpenInBrowserEnabled = false;
              server.systemTrayEnabled = false;
              server.socksProxyEnabled = false;
              server.webUIFlavor = "WebUI";
              server.webUIInterface = "browser";
              server.webUIChannel = "stable"; # "bundled" (the version bundled with the server release), "stable" or "preview" - the webUI version that should be used
              server.webUIUpdateCheckInterval = 23;
              server.globalUpdateInterval = 12;
              server.updateMangas = false;
            };
          };
        };
      };

      nginx.virtualHosts.${domain} =
        {
          enableAuthelia = true; # add custom authelia location

          extraConfig = ''
            location / {
              set $upstream_homer http://${host}:${toString port};  #CHANGE NAME AND IP AND PORT
              proxy_pass $upstream_homer;  #change name of the service

              auth_request /authelia;
              auth_request_set $target_url $scheme://$http_host$request_uri;
              auth_request_set $user $upstream_http_remote_user;
              auth_request_set $groups $upstream_http_remote_groups;
              proxy_set_header Remote-User $user;
              proxy_set_header Remote-Groups $groups;
              error_page 401 =302 https://auth.xilain.dev/?rd=$target_url; #change YOURDOMAIN.COM to your domain

              client_body_buffer_size 128k;

              proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;

              send_timeout 5m;
              proxy_read_timeout 360;
              proxy_send_timeout 360;
              proxy_connect_timeout 360;

              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
              proxy_set_header X-Forwarded-Uri $request_uri;
              proxy_set_header X-Forwarded-Ssl on;
              proxy_redirect  http://  $scheme://;
              proxy_http_version 1.1;
              proxy_set_header Connection "";
              proxy_cache_bypass $cookie_session;
              proxy_no_cache $cookie_session;
              proxy_buffers 64 256k;

              set_real_ip_from 192.168.1.0/16;
              real_ip_header X-Forwarded-For;
              real_ip_recursive on;
              proxy_pass_header Authorization;

            }
          '';
          quic = true;
        }
        // lib.sslTemplate;
    };
  };
}
