{
  location.provider = "geoclue2";

  services.geoclue2 = {
    # enable geoclue2 only if location.provider is geoclue2
    enable = true;

    # TODO: make gammastep fall back to local if geoclue2 is disabled
    appConfig.gammastep = {
      isAllowed = true;
      isSystem = false;
    };
  };
}
