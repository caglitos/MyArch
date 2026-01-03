#!/bin/bash

# Obtener sinks reales (solo RUNNING o IDLE)
mapfile -t SINKS < <(
  pactl list short sinks | awk '{print $1}'
)

# Sink actual
CURRENT=$(pactl get-default-sink)

# Encontrar índice actual
CURRENT_INDEX=0
for i in "${!SINKS[@]}"; do
  if [[ "${SINKS[$i]}" == "$CURRENT" ]]; then
    CURRENT_INDEX="$i"
    break
  fi
done

# Calcular siguiente
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#SINKS[@]} ))
NEXT="${SINKS[$NEXT_INDEX]}"

# Cambiar default
pactl set-default-sink "$NEXT"

# Mover TODOS los streams activos
pactl list short sink-inputs | awk '{print $1}' |
while read -r STREAM; do
  pactl move-sink-input "$STREAM" "$NEXT"
done
