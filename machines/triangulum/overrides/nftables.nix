{lib, ...}: let
  inherit (lib) entryBetween;
in {
  networking.nftables.rules = {
    inet.filter.input = {
      # endlessh chain
      endlessh = entryBetween ["basic-icmp6" "basic-icmp" "ping6" "ping"] ["default"] {
        protocol = "tcp";
        field = "dport";
        value = [22];
        policy = "accept";
      };

      # this allows nginx to respond to the domain challenges without passing each service through the firewall
      https = entryBetween ["basic-icmp6" "basic-icmp" "ping6" "ping"] ["default"] {
        protocol = "tcp";
        field = "dport";
        value = [443];
        policy = "accept";
      };

      headscale = entryBetween ["basic-icmp6" "basic-icmp" "ping6" "ping"] ["default"] {
        protocol = "udp";
        field = "dport";
        value = [3478];
        policy = "accept";
      };

      # NOTE: snm has an option to enable firewall ports by default, but my nftables abstractions
      # do not allow for us to use that option, so we'll just open the ports manually
      # I could probably add an entry that propagates the tcpPorts option to the firewall
      # but that doesn not seem like a very good option since we'll not be able to control policies
      simple-nixos-mailserver = entryBetween ["basic-icmp6" "basic-icmp" "ping6" "ping"] ["default"] {
        protocol = "tcp";
        field = "dport";
        value = [
          25 # smtp
          80 # used for acme-nginx domain challenges
          143 # imap
          993 # imapSsl
          465 # smtpSsl
        ];
        policy = "accept";
      };
    };

    #TODO
    # # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    # ip.nat.postrouting = {
    #   # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    #   # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
    #   wireguard = entryBetween ["default"] ["default"] {
    #     protocol = "all";
    #     field = "ip saddr";
    #     value = "10.0.0.0/24";
    #     policy = "masquerade";
    #   };
    # };
  };
}
