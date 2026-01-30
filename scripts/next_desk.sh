current_desk=$(hyprctl activeworkspace -j | jq '.id')
next_desk=$((current_desk + 1))
before_desk=$((current_desk - 1))

if [[ "$1" == "-" ]]; then
    hyprctl dispatch workspace $before_desk
elif [[ "$1" == "+" ]]; then
    hyprctl dispatch workspace $next_desk
fi
