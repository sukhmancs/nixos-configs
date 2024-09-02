{
  config,
  lib,
  ...
}: let
  inherit (lib) mkAgenixSecret;
  inherit (lib.strings) optionalString;
  autheliaUser =
    if ((config ? services.authelia.instances.main) && config.services.authelia.instances.main.enable)
    then config.services.authelia.instances.main.user
    else "";

  sys = config.modules;
  cfg = sys.services;
in {
  users = {
    groups = {
      lldap-secrets = {};
      gitea-secrets = {};

      miniflux-secrets = {};
    };
  };

  age.identityPaths = [
    "${optionalString sys.system.impermanence.root.enable "/persist"}/etc/ssh/ssh_host_ed25519_key"
    "${optionalString sys.system.impermanence.home.enable "/persist"}/home/xi/.ssh/id_ed25519"
  ];

  age.secrets = {
    # TODO: system option for declaring host as a potential builder
    # nix-builderKey = mkAgenixSecret true {
    #   file = "common/nix-builder.age";
    # };

    tailscale-client = mkAgenixSecret config.services.tailscale.enable {
      file = "client/tailscale.age";
      owner = "xi";
      group = "users";
      mode = "400";
    };

    # secrets needed for peers
    spotify-secret = mkAgenixSecret config.services.spotifyd.enable {
      file = "client/spotify.age";
      owner = "xi";
      group = "users";
      mode = "400";
    };

    wg-client = mkAgenixSecret config.networking.wireguard.enable {
      file = "client/wg.age";
      owner = "xi";
      group = "users";
      mode = "700";
    };

    client-email = mkAgenixSecret config.services.lldap.enable {
      file = "client/email.age";
      owner = "xi";
      group = "users";
      mode = "400";
    };

    # service secrets
    wg-server = mkAgenixSecret config.networking.wireguard.enable {
      file = "service/wg.age";
    };

    # mkm-web = mkAgenixSecret true {
    #   file = "service/mkm-web.age";
    #   mode = "400";
    # };

    matrix-secret = mkAgenixSecret config.services.matrix-synapse.enable {
      file = "service/matrix.age";
      owner = "matrix-synapse";
      mode = "440";
    };

    vaultwarden-env = mkAgenixSecret config.services.vaultwarden.enable {
      file = "service/vaultwarden.age";
      owner = "vaultwarden";
      mode = "440";
    };

    searx-secretkey = mkAgenixSecret config.services.searx.enable {
      file = "service/searx.age";
      mode = "440";
      owner = "searx";
      group = "searx";
    };

    nextcloud-secret = mkAgenixSecret config.services.nextcloud.enable {
      file = "service/nextcloud.age";
      mode = "400";
      owner = "nextcloud";
      group = "nextcloud";
    };

    # attic-env = mkAgenixSecret true {
    #   file = "service/attic.age";
    #   mode = "400";
    #   owner = "atticd";
    #   group = "atticd";
    # };

    harmonia-privateKey = mkAgenixSecret config.services.harmonia.enable {
      file = "service/harmonia.age";
      mode = "770";
      owner = "harmonia";
      group = "harmonia";
    };

    forgejo-runner-token = mkAgenixSecret config.services.forgejo.enable {
      file = "service/forgejo-runner-token.age";
      mode = "440";
      owner = "gitea-runner";
      group = "gitea-runner";
    };

    # forgejo-runner-config = mkAgenixSecret config.services.forgejo.enable {
    #   file = "service/forgejo-runner-config.age";
    #   mode = "440";
    #   owner = "gitea-runner";
    #   group = "gitea-runner";
    # };

    headscale-derp = mkAgenixSecret config.services.headscale.enable {
      file = "service/headscale-derp.age";
      mode = "400";
      owner = "headscale";
      group = "headscale";
    };

    headscale-noise = mkAgenixSecret config.services.headscale.enable {
      file = "service/headscale-noise.age";
      mode = "400";
      owner = "headscale";
      group = "headscale";
    };

    suwayomi-server-password = mkAgenixSecret config.services.suwayomi-server.enable {
      file = "service/suwayomi-server.age";
      mode = "440";
      owner = "suwayomi";
      group = "suwayomi";
    };

    # authelia secrets
    authelia_jwt_secret =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "authelia/jwt_secret.age";
        owner = autheliaUser;
      };

    authelia_session_secret =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "authelia/session_secret.age";
        owner = autheliaUser;
      };

    authelia_storage_encryption_key =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "authelia/storage_encryption_key.age";
        owner = autheliaUser;
      };

    authelia_postgre_password =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "authelia/postgre_password.age";
        owner = autheliaUser;
      };

    authelia_smtp_password =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "authelia/smtp_pass.age";
        owner = autheliaUser;
      };

    # lldap secrets
    lldap_jwt_secret = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/jwt_secret.age";
      mode = "440";
      owner = autheliaUser;
      group = "lldap-secrets";
    };

    lldap_user_pass = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/user_pass.age";
      mode = "440";
      owner = autheliaUser;
      group = "lldap-secrets";
    };

    lldap_private_key = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/private_key.age";
      mode = "440";
      group = "lldap-secrets";
    };

    lldap_key_seed = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/key_seed.age";
      mode = "440";
      group = "lldap-secrets";
    };

    # mailserver secrets
    mailserver-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/postmaster.age";
      mode = "400";
    };

    mailserver-forgejo-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/forgejo.age";
      owner = "forgejo";
      group = "forgejo";
      mode = "440";
    };

    mailserver-vaultwarden-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/vaultwarden.age";
      owner = "vaultwarden";
      mode = "400";
    };

    mailserver-cloud-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/cloud.age";
      owner = "nextcloud";
      mode = "400";
    };

    mailserver-matrix-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/matrix.age";
      owner = "matrix-synapse";
      mode = "400";
    };

    mailserver-noreply-secret = mkAgenixSecret (config.modules.device.type == "server") {
      file = "mailserver/noreply.age";
      owner = "mastodon";
      mode = "400";
    };

    mailserver-authelia-secret =
      mkAgenixSecret
      ((config ? services.authelia.instances.main)
        && config.services.authelia.instances.main.enable)
      {
        file = "mailserver/authelia.age";
        owner = autheliaUser;
      };
  };
}
