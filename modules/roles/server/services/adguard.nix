{
  lib,
  config,
  ...
}: let
  #   roleName = "adguard";
  #   roleEnabled = lib.elem roleName config.homelab.currentHost.roles;
  #   alias = "dns";
  #   aliasdefined = !(builtins.elem alias config.homelab.currentHost.dnsalias);
  #   cfg = config.services.adguardhome;
  # Function
  # Get Hosts IP
  #   hostsIps =
  #     lib.mapAttrsToList
  #     (
  #       name: host: {
  #         domain = name;
  #         answer = host.ipv4;
  #       }
  #     )
  #     config.homelab.hosts;
  #   # Function
  #   # Get Alias IP
  #   aliasIps =
  #     lib.flatten
  #     (
  #       lib.mapAttrsToList
  #       (
  #         name: host: let
  #           alias = lib.optionals (host.dnsalias != null) host.dnsalias;
  #         in
  #           map
  #           (entry: {
  #             domain = entry;
  #             answer = host.ipv4;
  #           })
  #           alias
  #       )
  #       config.homelab.hosts
  #     );
  sys = config.modules.system;
  cfg = sys.services;

  domain = "dns.xilain.dev";

  inherit (cfg.adguard.settings) port host;
in {
  config = {
    networking.firewall.allowedTCPPorts = [80 443];
    networking.firewall.allowedUDPPorts = [53];

    services = {
      adguardhome = {
        enable = true;
        mutableSettings = false;
        port = port;
        openFirewall = true;
        settings = {
          http.address = "${host}:${toString port}";
          schema_version = 20;
          theme = "dark"; # Dark theme
          dns = {
            ratelimit = 30; # DDoS protection
            refuse_any = true; # Request of type ANY will be refused
            # enable_dnssec = true; # DNSSEC validation
            bind_hosts = ["0.0.0.0"];
            anonymize_client_ip = true;
            bootstrap_dns = [
              "9.9.9.10"
              "149.112.112.10"
              "2620:fe::10"
              "2620:fe::fe:10"
            ];
            upstream_dns = [
              "1.1.1.1"
              "1.0.0.1"
              "8.8.8.8"
              "8.8.4.4"
            ];
            #   rewrites = hostsIps ++ aliasIps;
          };
          filtering = {
            protection_enabled = true;
            filtering_enabled = true;

            parental_enabled = false; # Parental control-based DNS requests filtering.
            safe_search = {
              enabled = false; # Enforcing "Safe search" option for search engines, when possible.
            };
          };
          # The following notation uses map
          # to not have to manually create {enabled = true; url = "";} for every filter
          # This is, however, fully optional
          filters =
            map (url: {
              enabled = true;
              url = url;
            }) [
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt" # Steven black's hosts file
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_18.txt" # Filter Phishing domains
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt" # Anti-mailware list
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_30.txt" # Filter Phishing domains based on PhishTank and OpenPhish lists"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_57.txt" # Block dating sites
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt" # Block gambling sites
            ];
        };
      };

      nginx.virtualHosts.${domain} =
        {
          enableAuthelia = true; # add custom authelia location

          extraConfig = ''
            location / {
              set $upstream_homer http://127.0.0.1:${toString port};  #CHANGE NAME AND IP AND PORT
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
            }
          '';

          # locations."/" = {
          #   proxyPass = "http://127.0.0.1:${toString port}";
          # };
          quic = true;
        }
        // lib.sslTemplate;
    };
  };
}
