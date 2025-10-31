#!/bin/bash
# Ein "brüchiges" Legacy-Skript (Mock-up)

echo "[Legacy] Starte Rechnungsverarbeitung..."

# Simuliert einen Fehler bei jeder zweiten Ausführung
RANDOM_NUM=$((1 + $RANDOM % 10))

if [ $(($RANDOM_NUM % 2)) -eq 0 ]; then
    echo "[Legacy] FEHLER: Konnte Datenbank nicht erreichen." >&2
    exit 1 # Simuliert einen harten Absturz (P10)
fi

echo "[Legacy] Verarbeite Rechnung #123..."
sleep 1 # Simuliert Arbeit
echo "[Legacy] Verarbeite Rechnung #124..."
sleep 1 # Simuliert Arbeit

echo "[Legacy] Rechnungsverarbeitung erfolgreich abgeschlossen."
exit 0
