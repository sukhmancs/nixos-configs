{pkgs, ...}: let
  inherit (pkgs.lib) getExe;

  imv = ''${pkgs.lib.getExe' pkgs.imv "imv"}'';
  lynx = "${getExe pkgs.lynx}";
  zathura = "${getExe pkgs.zathura}";
in
  pkgs.writeShellScriptBin "rofiHandler" ''
    #!/bin/sh

    # This script is a simple rofi handler for opening URLs in various programs.
    # It is meant to be used with newsboat, but can be used with any program that
    # outputs URLs to stdout.
    # Make sure $BROWSER, $TERMINAL, and $EDITOR are set in your environment.

    # Check if required environment variables are set
    if [ -z "$BROWSER" ] || [ -z "$TERMINAL" ] || [ -z "$EDITOR" ]; then
      echo "Error: Required environment variables BROWSER, TERMINAL, or EDITOR are not set."

      if command -v notify-send >/dev/null 2>&1; then
        notify-send "Error: Required environment variables BROWSER, TERMINAL, or EDITOR are not set."
      fi
      exit 1
    fi

    if [ -z "$1" ]; then
      echo "Error: No URL provided."
      exit 1
    fi

    echo "Opening $1"

    feed="$1"

    case "$(printf "<span font='FontAwesome'>\uf268 </span> browser\n<span font='FontAwesome'>\uf03e </span> imv\n<span font='FontAwesome'>\uf1c1 </span> PDF\n<span font='FontAwesome'>\uf0c1 </span> lynx\n<span font='FontAwesome'>\uf044 </span> vim\n<span font='FontAwesome'>\uf144 </span> mpv\n<span font='FontAwesome'>\uf144 </span> mpv loop\n<span font='FontAwesome'>\uf144 </span> mpv float\n" | rofi -dmenu -i -p "Open it with?" -markup-rows | sed 's/.*span> //; s/%$//')" in
        browser) setsid -f $BROWSER "$feed" >/dev/null 2>&1 ;;
        nimv) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && ${imv} "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        PDF) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && "${zathura}" "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        lynx) "${lynx} -anonymous -accept_all_cookies" $feed >/dev/null 2>&1 ;;
        vim) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && setsid -f "$TERMINAL" -e "$EDITOR" "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" >/dev/null 2>&1 ;;
        mpv) setsid -f mpv -quiet "$feed" >/dev/null 2>&1 ;;
        "mpv loop") setsid -f mpv -quiet --loop "$feed" >/dev/null 2>&1 ;;
        "mpv float") setsid -f "$TERMINAL" -e mpv --geometry=+0-0 --autofit=30%  --title="mpvfloat" "$feed" >/dev/null 2>&1 ;;
    esac
  ''
