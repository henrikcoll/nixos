#scripts="$(printf "mango\nwallpaper\nlights\nssh")"
#script="$(echo "$scripts" | rofi -dmenu -p menu -theme gruvbox-dark -kb-select-1 "1" -kb-select-2 "2")"

#if [ "$script" = "mango" ]; then
    
#fi

#if [ "$script" = "ssh" ]; then
#    rofi -theme gruvbox-dark -show ssh
#fi

#if [ "$script" = "lights" ]; then
#    scripts="$(printf "taklampe")"
#    script="$(echo "$scripts" | rofi -dmenu -p lights -theme gruvbox-dark -kb-select-1 "1")"
#
#    source $(dirname "$0")/.secrets
#    curl \
#      -H "Authorization: Bearer $HA_API_TOKEN" \
#      -H "Content-Type: application/json" \
#      "$HA_API_URL/api/services/light/toggle" \
#      -d '{"entity_id": "light.hue_color_lamp_1_2"}'
#fi

#if [ "$script" = "wallpaper" ]; then
#    wp_actions="playlist-next\ncycle pause\nplaylist-prev"
#    wp_action="$(printf "$wp_actions" | rofi -dmenu -p wallpaper -theme gruvbox-dark)"
#
#    echo "$wp_action" | socat - /run/user/1000/mpv
#fi

DISPLAY="\0display\x1f"

function menu() {
	printf "$1" | rofi -dmenu -format s -theme gruvbox-dark
}

function mango_layouts() {
    LAYOUTS="T${DISPLAY}[T]  Tile"
    LAYOUTS="$LAYOUTS\nG${DISPLAY}[G]  Grid"
    LAYOUTS="$LAYOUTS\nM${DISPLAY}[M]  Monocle"
    LAYOUTS="$LAYOUTS\nK${DISPLAY}[K]  Deck"
    LAYOUTS="$LAYOUTS\nCT${DISPLAY}[CT] Center Tile"
    LAYOUTS="$LAYOUTS\nRT${DISPLAY}[RT] Reverse Tile"
    LAYOUTS="$LAYOUTS\nVS${DISPLAY}[VS] Vertical Scroll"
    LAYOUTS="$LAYOUTS\nVT${DISPLAY}[VT] Vertical Tile"
    LAYOUTS="$LAYOUTS\nVG${DISPLAY}[VG] Vertical Grid"
    LAYOUTS="$LAYOUTS\nVK${DISPLAY}[VK] Vertical Deck"
    LAYOUTS="$LAYOUTS\nS${DISPLAY}[S]  Scroll"
    LAYOUT=$(menu "$LAYOUTS")

    mmsg -l $LAYOUT
}

case "$(menu "layouts\ntags\nwallpaper\nlights\nssh")" in
    "layouts")
        mango_layouts;;
    "wallpaper")
        menu "TODO";;
    "lights")
        menu "TODO";;
    "ssh")
        menu "TODO";;
esac
