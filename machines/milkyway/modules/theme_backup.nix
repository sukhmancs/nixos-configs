{
  config,
  pkgs,
  ...
}: {
  config.modules.stylix = {
    theme = {
      name = "Gruvbox Dark Hard";
      package = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    };
    polarity = "dark";
    wallpaper = {
      backgroundUrl = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      backgroundSha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    globalThemeEnable = false;

    settings = {
      font = "Intel One Mono";
      fontPkg = pkgs.intel-one-mono;
    };
  };
}
