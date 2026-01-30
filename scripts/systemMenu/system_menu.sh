#!/usr/bin/env bash

show_about_system() {
  local systemVersion cpuInfo ramInfo uptimeInfo host kernelInfo
  local pacmanPackageCount flatpakPackageCount 
  
  local choice

  systemVersion=$(fastfetch --logo none --structure Os)
  cpuInfo=$(grep -m1 'model name' /proc/cpuinfo | sed 's/.*: //')
  ramInfo=$(free -h | awk '/Mem:/ {print $2 " Total, " $3 " Used"}')
  uptimeInfo=$(uptime -p | sed 's/^up //')
  host=$(fastfetch --logo none --structure Host | sed 's/^Host[[:space:]]*//')
  kernelInfo=$(uname -r)
  pacmanPackageCount=$(pacman -Qq | wc -l)
  flatpakPackageCount=$(flatpak list --app | wc -l)


  choice=$(printf "About System\n\n\
    System %s\n\
    CPU %s\n\
    RAM %s\n\
    Uptime %s\n\
    Kernel %s\n\
    Host %s\n\
    Packages %s (pacman) %s (flatpak)\n" \
    "$systemVersion" "$cpuInfo" "$ramInfo" "$uptimeInfo" \
    "$kernelInfo" "$host" \
    "$pacmanPackageCount" "$flatpakPackageCount" |
    wofi --dmenu --width 400 -l 1 --lines 9 --prompt "")

    case "$choice" in
      *CPU*) kitty -e btop ;;
      *RAM*) kitty -e btop ;;
      *Uptime*) kitty ~ ;;
      *Packages*) kitty -e bash -c 'sudo pacman -Syu; cd ~; cls; exec bash';;
    esac

}


show_menu() {
  local choice

  choice=$(printf "About System\nHibernate\nReboot\nPower Off\nSuspend\nLog Out" |
    wofi --dmenu --width 260 -l 1 --lines 6 --prompt "")

  case "$choice" in
    "About System") show_about_system ;;
    "Hibernate") systemctl hibernate ;;
    "Reboot") systemctl reboot ;;
    "Power Off") systemctl poweroff ;;
    "Suspend") systemctl suspend ;;
    "Log Out") hyprctl dispatch exit ;;
  esac
}

show_menu
