{colors}:
with colors; let
  OSLogo = builtins.fetchurl rec {
    name = "OSLogo-${sha256}.png";
    sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg";
  };
in ''
  * {
    font-family: Material Design Icons, Iosevka Nerd Font Mono;
    font-size: 19px;
  }

  window#waybar {
    background-color: #${base00};
    border: .5px solid #${base01};
    border-radius: 0px;
    color: #${base05};
    margin: 8px 8px;
    transition-property: background-color;
    transition-duration: .5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  .modules-left {
    margin: 7px 7px 7px 7px;
    background-color: #${base02};
    border: .5px solid #${base01};
    border-radius: 15px;
    padding: 2px 2px;
  }

  .modules-center {
    margin: 7px 7px 7px 7px;
    background-color: #${base02};
    border: .5px solid #${base01};
    border-radius: 15px;
    padding: 2px 0px 2px 0px;
  }

  .modules-right {
    margin: 7px 7px 7px 7px;
    background-color: #${base02};
    border: .5px solid #${base01};
    border-radius: 15px;
    padding: 2px 0px 2px 0px;
  }

  #custom-weather,
  #clock,
  #network,
  #custom-swallow,
  #custom-power,
  #cpu,
  #battery,
  #backlight,
  #memory,
  #tags,
  #custom-search,
  #custom-power,
  #custom-todo,
  #custom-lock,
  #custom-weather,
  #volume,
  #cpu,
  #bluetooth,
  #gamemode,
  #gcpu,
  #memory,
  #disk,
  #submap,
  #pulseaudio {
    padding: 4px 0px 4px 0px;
    margin: 0px 0px;
    border-radius: 15px;
  }

  #tags button {
    background-color: transparent;
    /* Use box-shadow instead of border so the text isn't offset */
    color: #${base07};
    font-size: 21px;
    /* padding-left: 6px; */
    box-shadow: inset 0 -3px transparent;
  }

  #tags button:hover {
    color: #${base05};
    background-color: #${base03};
  }

  #tags button.focused {
    border-radius: 20px;
    border-color: #${base0E};
  }

  #tags button.occupied {
    color: #${base0E};
  }

  #tags button.urgent {
    color: #${base08};
  }

  #custom-power {
    color: #${base08};
    margin-bottom: 7px;
  }

  #tags {
    background-color: #${base02};
  }

  #network {
    color: #${base07};

  }

  #gamemode {
    color: #${base07};
  }

  #custom-weather {
    color: #${base05};
    background-color: #${base02};
  }

  #bluetooth {
    color: #${base0E};
  }

  #bluetooth.off,
  #bluetooth.pairable,
  #bluetooth.discovering,
  #bluetooth.disabled {
    color: rgba(0, 0, 0, 0.0);
    background-color: rgba(0, 0, 0, 0.0);
    margin: -50;
  }

  #clock {
    color: #${base05};
    background-color: #${base02};
    font-weight: 700;
    font-size: 20px;
    font-family: "Iosevka Term";
  }

  #pulseaudio {
    color: #${base0B};
  }

  #pulseaudio.source-muted,
  #pulseaudio.muted {
    color: #${base08};
  }

  #custom-swallow {
    color: #${base0E};

  }

  #custom-lock {
    color: #${base07};

  }

  #custom-todo {
    color: #${base05};
  }

  #custom-cpu {
    color: #${base0B};
  }

  #custom-search {
    background-image: url("${OSLogo}");
    background-size: 65%;
    background-position: center;
    background-repeat: no-repeat;
    margin-top: 7px;
  }

  #backlight {
    color: #${base0A};
  }

  #battery {
    color: #${base0C};
  }

  #battery.warning {
    color: #${base09};
  }

  #battery.critical:not(.charging) {
    color: #${base08};
  }

  tooltip {
    font-family: 'Lato', sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
  }

  tooltip label {
    font-family: 'Lato', sans-serif;
    padding: 20px;
  }
''
