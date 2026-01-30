#!/bin/bash

# 🟢 RESTAURAR SERVICIOS
SERVICES=(
  bluetooth
  ollama
  rtkit-daemon
  upower
  systemd-timesyncd
  sshd
  polkit
)

for s in "${SERVICES[@]}"; do
  sudo systemctl start "$s" 2>/dev/null
  sudo systemctl enable "$s" 2>/dev/null
done

# NetworkManager wait-online (por si lo usas)
sudo systemctl start NetworkManager-wait-online.service 2>/dev/null
sudo systemctl enable NetworkManager-wait-online.service 2>/dev/null

# ⚡ CPU governor → powersave / schedutil
if [[ -d /sys/devices/system/cpu/cpu0/cpufreq ]]; then
  for g in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo schedutil | sudo tee "$g" >/dev/null || \
    echo powersave | sudo tee "$g" >/dev/null
  done
fi

# ▶️ Hyprland
exec start-hyprland
