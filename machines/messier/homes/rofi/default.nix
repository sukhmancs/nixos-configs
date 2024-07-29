#
# Rofi - rofi with wayland plugins
#
{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: let
  inherit (lib) mkForce;
  inherit (osConfig) modules;
  inherit (modules.themes) colors;

  # rofiTheme = pkgs.writeText "andromeda.rasi" (import ./rasi.nix {inherit osConfig;});
  rasiContent = import ./rasi.nix {inherit osConfig pkgs;};
  # rofiRasi = pkgs.writeText "rofi.rasi" rofiThemePath;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override {
      plugins = with pkgs; [
        (rofi-calc.override {
          rofi-unwrapped = rofi-wayland-unwrapped;
        })
        (rofi-emoji.override {
          rofi-unwrapped = rofi-wayland-unwrapped;
        })
      ];
    };
    font = mkForce "Iosevka Nerd Font 14";
    extraConfig = mkForce {
      modi = "drun,calc,emoji,filebrowser";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      sidebar-mode = true;
      matching = "prefix";
      scroll-method = 0;
      disable-history = false;
      show-icons = false;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      display-calc = " ";
      display-emoji = " ";
    };

    theme = let
      inherit (osConfig) modules;
      inherit (modules.themes) colors;
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background = mkLiteral "#${colors.base01}";
        background-alt = mkLiteral "#${colors.base00}";
        foreground = mkLiteral "#${colors.base05}";
        selected = mkLiteral "#${colors.accent}";
        active = mkLiteral "#${colors.accent}";
        urgent = mkLiteral "#${colors.base08}";

        borderColour = "var(selected)";
        handleColour = "var(foreground)";
        backgroundColour = "var(background)";
        foregroundColour = "var(foreground)";
        alternateBackground = "var(background-alt)";
        normalBackground = "var(background)";
        normalForeground = "var(foreground)";
        urgentBackground = "var(urgent)";
        urgentForeground = "var(background)";
        activeBackground = "var(active)";
        activeForeground = "var(background)";
        selectedNormalBackground = "var(selected)";
        selectedNormalForeground = "var(background)";
        selectedUrgentBackground = "var(active)";
        selectedUrgentForeground = "var(background)";
        selectedActiveBackground = "var(urgent)";
        selectedActiveForeground = "var(background)";
        alternateNormalBackground = "var(background)";
        alternateNormalForeground = "var(foreground)";
        alternateUrgentBackground = "var(urgent)";
        alternateUrgentForeground = "var(background)";
        alternateActiveBackground = "var(active)";
        alternateActiveForeground = "var(background)";
      };
      "window" = {
        transparency = "real";
        location = "center";
        anchor = "center";
        fullscreen = false;
        width = "500px";
        x-offset = "0px";
        y-offset = "0px";
        enabled = true;
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "8px";
        border-color = mkLiteral "@borderColour";
        cursor = "default";
        background-color = mkLiteral "@backgroundColour";
      };
      "mainbox" = {
        enabled = true;
        spacing = "10px";
        margin = "0px";
        padding = "40px";
        border = "0px solid";
        border-radius = "0px 0px 0px 0px";
        border-color = "@borderColour";
        background-color = "transparent";
        children = mkLiteral "[inputbar,message,listview,mode-switcher]";
      };
      "inputbar" = {
        enabled = true;
        spacing = "10px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
        border-color = "@borderColour";
        background-color = "transparent";
        text-color = "@foregroundColour";
        children = mkLiteral "[prompt,entry]";
      };
      "entry" = {
        enabled = true;
        background-color = "inherit";
        text-color = "inherit";
        cursor = "text";
        placeholder = "search...";
        placeholderColor = "inherit";
      };
      "prompt" = {
        enabled = true;
        background-color = "inherit";
        text-color = "inherit";
      };
      "textbox-prompt-colon" = {
        enabled = true;
        expand = false;
        str = "::";
        background-color = "inherit";
        text-color = "inherit";
      };

      "num-filtered-rows" = {
        enabled = true;
        expand = false;
        background-color = "inherit";
        text-color = "inherit";
      };
      "textbox-num-sep" = {
        enabled = true;
        expand = false;
        str = "/";
        background-color = "inherit";
        text-color = "inherit";
      };
      "num-rows" = {
        enabled = true;
        expand = false;
        background-color = "inherit";
        text-color = "inherit";
      };

      "case-indicator" = {
        enabled = true;
        background-color = "inherit";
        text-color = "inherit";
      };
      "listview" = {
        enabled = true;
        columns = 1;
        lines = 12;
        cycle = true;
        dynamic = true;
        scrollbar = true;
        layout = "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = "5px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
        border-color = "@borderColour";
        background-color = "transparent";
        text-color = "@foregroundColour";
        cursor = "default";
      };
      "scrollbar" = {
        handle-width = "5px";
        handle-color = "@handleColour";
        border-radius = "8px";
        background-color = "@alternateBackground";
      };
      "element" = {
        enabled = true;
        spacing = "8px";
        margin = "0px";
        padding = "8px";
        border = "0px solid";
        border-radius = "4px";
        border-color = "@borderColour";
        background-color = "transparent";
        text-color = "@foregroundColour";
        cursor = "pointer";
      };
      "element normal.normal" = {
        background-color = "@normalBackground";
        text-color = "@normalForeground";
      };
      "element normal.urgent" = {
        background-color = "@urgentBackground";
        text-color = "@urgentForeground";
      };
      "element normal.active" = {
        background-color = "@activeBackground";
        text-color = "@activeForeground";
      };
      "element selected.normal" = {
        background-color = "@normalForeground";
        text-color = "@normalBackground";
      };
      "element selected.urgent" = {
        background-color = "@selectedUrgentBackground";
        text-color = "@selectedUrgentForeground";
      };
      "element selected.active" = {
        background-color = "@selectedActiveBackground";
        text-color = "@selectedActiveForeground";
      };
      "element-icon" = {
        background-color = "transparent";
        text-color = "inherit";
        size = "24px";
        cursor = "inherit";
      };
      "element-text" = {
        background-color = "transparent";
        text-color = "inherit";
        highlight = "inherit";
        cursor = "inherit";
        vertical-align = "0.5";
        horizontal-align = "0.0";
      };
      "mode-switcher" = {
        enabled = true;
        spacing = "10px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
        border-color = "@borderColour";
        background-color = "transparent";
        text-color = "@foregroundColour";
      };
      "button" = {
        padding = "8px";
        border = "0px solid";
        border-radius = "4px";
        border-color = "@borderColour";
        background-color = "@alternateBackground";
        text-color = "inherit";
        cursor = "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };

      "message" = {
        enabled = true;
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px 0px 0px 0px";
        border-color = "@borderColour";
        background-color = "transparent";
        text-color = "@foregroundColour";
      };
      "textbox" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "error-message" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };

  #   home.file.".config/rofi/config.rasi" = {
  #     text = rasiContent;
  #   };
}
