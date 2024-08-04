{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in
  pkgs.writeShellScriptBin "rofiHandler" ''
    #!/bin/sh

    # Feed this script a link and it will give rofi
    # some choice programs to use to open it.
    feed="$\{1:-$(true | rofi -dmenu -p 'Paste URL or file path')}"

    case "$(printf "nbrowser\nimv\nPDF\nlynx\nvim\nmpv\nmpv loop\nmpv float" | rofi -dmenu -i -p "Open it with?")" in
        browser) setsid -f "${BROWSER:-firefox}" "$feed" >/dev/null 2>&1 ;;
        nimv) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && ${pkgs.imv} "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        PDF) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && ${pkgs.zathura} "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        lynx) ${getExe pkgs.lynx} "$feed" >/dev/null 2>&1 ;;
        vim) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && setsid -f "${TERMINAL:-foot}" -e "${EDITOR:-nvim}" "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        mpv) setsid -f mpv -quiet "$feed" >/dev/null 2>&1 ;;
        "mpv loop") setsid -f mpv -quiet --loop "$feed" >/dev/null 2>&1 ;;
        "mpv float") setsid -f "${TERMINAL:-foot}" -e mpv --geometry=+0-0 --autofit=30%  --title="mpvfloat" "$feed" >/dev/null 2>&1 ;;
    esac
  ''
