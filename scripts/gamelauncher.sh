#!/bin/bash

# 🔥 BENCH MODE SYSTEM SERVICES
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
  sudo systemctl stop "$s" 2>/dev/null
done

sudo systemctl stop NetworkManager-wait-online.service 2>/dev/null

# ⚡ CPU governor
if [[ -d /sys/devices/system/cpu/cpu0/cpufreq ]]; then
  for g in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance | sudo tee "$g" >/dev/null
  done
fi

export MESA_GL_VERSION_OVERRIDE=4.6
export MESA_GLSL_VERSION_OVERRIDE=460
export RADV_PERFTEST=aco

# ▶️ River
exec dbus-run-session river
