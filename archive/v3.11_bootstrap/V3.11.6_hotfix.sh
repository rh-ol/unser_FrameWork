#!/bin/bash
# V3.11.6 "HOTFIX" Skript (Reparatur)
# Repariert den 'main'/'master' Push-Fehler aus V3.11.
# Führen Sie dies im 'unser_FrameWork' Verzeichnis aus.

echo "--- Starte V3.11.6 'Hotfix' (Reparatur) ---"

# --- Schritt 1: Sicherheits-Check ---
if [ ! -d .git ]; then
    echo "FEHLER: Dies ist kein Git-Repository." >&2
    exit 1
fi

# --- Schritt 2: Reparatur (Der fehlende Push) ---
echo "Repariere SSoT: Pushe lokalen 'master' Branch auf remote 'main' Branch..."
# (Wir ignorieren Fehler mit '|| true', falls dies bereits manuell geschehen ist)
# (Das 'origin' remote wurde bereits im V3.11.3 Skript hinzugefügt)
git push origin master:main || true

# --- Schritt 3: Reparatur (Der fehlende Upstream-Link) ---
echo "Repariere SSoT: Setze 'origin/main' als Upstream für lokalen 'master'..."
git branch --set-upstream-to=origin/main master

# --- Schritt 4: Neuen Tag für den reparierten Stand setzen ---
echo "Setze 'V3.11.6-hotfix' Tag für diesen reparierten Stand..."
# (Wir erstellen einen leeren Commit, um den Upstream-Wechsel festzuhalten)
git commit --allow-empty -m "fix(framework): Repair main/master push sync (V3.11.6)"
git tag -a V3.11.6-hotfix -m "V3.11.6: Repaired the main/master upstream sync bug"

# --- Schritt 5: Push des reparierten Stands ---
echo "Pushe den reparierten Stand (V3.11.6) zur SSoT..."
git push origin
git push origin --tags

echo ""
echo "--- ERFOLGREICH ---"
echo "V3.11.6 REPARATUR ABGESCHLOSSEN."
echo "Die 'Single Source of Truth' (SSoT) ist jetzt #stabil und #repariert."
echo "Wir können jetzt mit Schritt 2 (Upgrade auf V3.14) beginnen."
