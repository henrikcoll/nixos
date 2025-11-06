scripts="$(printf "lights\nssh")"
script="$(echo "$scripts" | rofi -dmenu -p menu -theme gruvbox-dark -kb-select-1 "1" -kb-select-2 "2")"

echo "'$script'"

if [ "$script" = "ssh" ]; then
    rofi -theme gruvbox-dark -show ssh
fi

if [ "$script" = "lights" ]; then
    scripts="$(printf "taklampe")"
    script="$(echo "$scripts" | rofi -dmenu -p lights -theme gruvbox-dark -kb-select-1 "1")"

    source $(dirname "$0")/.secrets
    curl \
      -H "Authorization: Bearer $HA_API_TOKEN" \
      -H "Content-Type: application/json" \
      "$HA_API_URL/api/services/light/toggle" \
      -d '{"entity_id": "light.hue_color_lamp_1_2"}'
fi
