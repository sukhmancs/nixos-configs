{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
in {
  config = {
    programs = {
      # password-store pass
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [exts.pass-otp exts.pass-audit exts.pass-update exts.pass-import]);
        settings = {
          PASSWORD_STORE_DIR = "/home/${sys.mainUser}/.password-store";
          PASSWORD_STORE_KEY = "14304B9FBA97951FAA282C3E682A124CA91EBD05";
          PASSWORD_STORE_CLIP_TIME = "30";
          PASSWORD_STORE_GENERATED_LENGTH = "120";
          PASSWORD_STORE_CHARACTER_SET = "A-Za-z0-9!@#$%";
          PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS = "A-Za-z0-9";
          PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
        };
      };
    };

    services = {
      # Enable pass to integrate with the libsecret D-Bus API for password management
      pass-secret-service = {
        enable = true;
      };
    };

    #  home.file.".config/pass-git-helper" = {
    #    source = ./git-pass-mapping;
    #    recursive = true;
    #  };
  };
}
