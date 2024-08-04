{pkgs, ...}: let
  lynx = pkgs.lynx;
in
  pkgs.writeShellScript "rofi-menu-handler" ''
    #!/usr/bin/env bash

    # Feed this script a link and it will give rofi
    # some choice programs to use to open it.
    feed="$\{1:-$(true | rofi -dmenu -p 'Paste URL or file path')}"

    case "$(printf "copy url\nnsxiv\nsetbg\nPDF\nbrowser\nlynx\nvim\nmpv\nmpv loop\nmpv float" | rofi -dmenu -i -p "Open it with?")" in
        "copy url") echo "$feed" | xclip -selection clipboard ;;
        mpv) setsid -f mpv -quiet "$feed" >/dev/null 2>&1 ;;
        "mpv loop") setsid -f mpv -quiet --loop "$feed" >/dev/null 2>&1 ;;
        "mpv float") setsid -f "$TERMINAL" -e mpv --geometry=+0-0 --autofit=30%  --title="mpvfloat" "$feed" >/dev/null 2>&1 ;;
        PDF) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && zathura "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        nsxiv) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && nsxiv -a "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        vim) curl -sL "$feed" > "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")" && setsid -f "$TERMINAL" -e "$EDITOR" "/tmp/$(echo "$feed" | sed "s|.*/||;s/%20/ /g")"  >/dev/null 2>&1 ;;
        setbg) curl -L "$feed" > $XDG_CACHE_HOME/pic ; xwallpaper --zoom $XDG_CACHE_HOME/pic >/dev/null 2>&1 ;;
        browser) setsid -f "$BROWSER" "$feed" >/dev/null 2>&1 ;;
        lynx) ${lynx} "$feed" >/dev/null 2>&1 ;;
    esac
  ''
