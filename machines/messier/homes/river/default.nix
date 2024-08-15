{
  pkgs,
  osConfig,
  ...
}: let
  init-binds = import ./binds.nix {inherit pkgs;};

  c = osConfig.modules.themes.colors;
in {
  home.file.".config/river/init" = {
    executable = true;
    text = ''
      #!/bin/sh

      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=river

      ${init-binds}

      TOUCHPAD=$(riverctl list-inputs | rg Touchpad)
      TRACKPOINT=$(riverctl list-inputs | rg TrackPoint)
      riverctl input $TOUCHPAD pointer-accel 0.5
      riverctl input $TOUCHPAD accel-profile flat
      riverctl input $TOUCHPAD natural-scroll enabled
      riverctl input $TOUCHPAD click-method clickfinger
      riverctl input $TOUCHPAD tap enabled
      riverctl input $TOUCHPAD disable-when-typing enabled

      riverctl input $TRACKPOINT pointer-accel -0.3

      # riverctl keyboard-layout -options "caps:escape" pl
      riverctl keyboard-layout 'us(dvorak)'

      riverctl set-repeat 30 350

      riverctl background-color "0x${c.base00}"
      riverctl border-color-focused "0x${c.base0E}"
      riverctl border-color-unfocused "0x${c.base02}"

      riverctl default-layout rivertile

      # Make certain views start floating
      riverctl float-filter-add app-id float
      riverctl float-filter-add app-id 'pavucontrol'
      riverctl float-filter-add app-id 'Timeshift-gtk'
      riverctl float-filter-add app-id 'pavucontrol'
      riverctl float-filter-add app-id 'nm-connection-editor'
      riverctl float-filter-add app-id 'nwg-look'
      riverctl float-filter-add app-id 'valent'
      riverctl float-filter-add app-id 'file-roller'
      riverctl float-filter-add app-id 'GParted'
      riverctl float-filter-add app-id 'ristretto'
      riverctl float-filter-add title "popup title with spaces"
      riverctl float-filter-add title "Open File"
      riverctl float-filter-add title "File Operation Progress"
      riverctl float-filter-add title "Preferences"
      riverctl float-filter-add title "dialog"
      riverctl float-filter-add title "Picture-in-Picture"
      riverctl float-filter-add title "bubble"
      riverctl float-filter-add title "task_dialog"
      riverctl float-filter-add title "menu"
      riverctl float-filter-add title "Confirm to replace files"

      # Set app-ids and titles of views which should use client side decorations
      riverctl csd-filter-add app-id "gedit"

      riverctl focus-follows-cursor normal
      riverctl hide-cursor when-typing enabled

      rivertile -view-padding 3 -outer-padding 3 &

      mako &
    '';
  };
}
