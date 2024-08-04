{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in
  pkgs.writeShellScriptBin "rofiHandler" ''
    #!/bin/sh

    # Feed this script a link and it will give rofi
    # some choice programs to use to open it.
    # feed="$\{1:-$(true | rofi -dmenu -p 'Paste URL or file path')}"
    if [ -z "$1" ]; then
      echo "Error: No URL provided."
      exit 1
    fi

    echo "Opening $1"

    feed="$1"

    case "$(printf "<span font='FontAwesome'>\uf268 </span> browser\\n<span font='FontAwesome'>\uf03e </span> imv\\n<span font='FontAwesome'>\uf1c1 </span> PDF\n<span font='FontAwesome'>\uf0c1 </span> lynx\n<span font='FontAwesome'>\uf044 </span> vim\n<span font='FontAwesome'>\uf144 </span> mpv\n<span font='FontAwesome'>\uf144 </span> mpv loop\n<span font='FontAwesome'>\uf144 </span> mpv float" | rofi -dmenu -i -p "Open it with?" -markup-rows)" in
        browser) setsid -f firefox "$feed" ;; #>/dev/null 2>&1 ;;
        nimv) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && ${pkgs.imv} "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        PDF) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && ${pkgs.zathura} "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        lynx) ${getExe pkgs.lynx} "$feed" ;; # >/dev/null 2>&1 ;;
        vim) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && setsid -f "foot" -e "$EDITOR" "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" ;; #  >/dev/null 2>&1 ;;
        mpv) setsid -f mpv -quiet "$feed" >/dev/null 2>&1 ;;
        "mpv loop") setsid -f mpv -quiet --loop "$feed" >/dev/null 2>&1 ;;
        "mpv float") setsid -f "$TERMINAL" -e mpv --geometry=+0-0 --autofit=30%  --title="mpvfloat" "$feed" >/dev/null 2>&1 ;;
    esac
  ''
