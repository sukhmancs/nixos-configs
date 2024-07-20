{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    palette = "default";

    templates = {
      #   ags = {
      #     input_path = "./templates/ags.scss";
      #     output_path = "~/.config/ags/scss/colors.scss";
      #   };

      #   kittty = {
      #     input_path = "./templates/kitty.conf";
      #     output_path = "~/.config/kitty/colors.conf";
      #   };

      gtk = {
        input_path = "./templates/gtk.css";
        output_path = "~/.config/gtk-4.0/gtk.css";
      };

      #   hypr = {
      #     input_path = "./templates/hypr.conf";
      #     output_path = "~/.config/hypr/colors.conf";
      #   };

      #   yazi = {
      #     input_path = "./templates/yazi.toml";
      #     output_path = "~/.config/yazi/theme.toml";
      #   };
    };
  };

  home.configFile."gtk-4.0/gtk.css".source = "${config.programs.matugen.theme.files}/.config/gtk-4.0/gtk.css";
}
