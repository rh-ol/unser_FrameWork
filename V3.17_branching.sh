#!/bin/bash
# V3.17-E (P22) "Fauler Modus" Skript (Positionsunabhängig)
# Führt den Branching-Prozess aus, wird aus dem Projekt-Root ausgeführt.

echo "--- Starte V3.17-E (Schritt 2: Branching) ---"

# --- Schritt 1: Definiere SSoT (Basis) ---
# (Da wir uns im korrekten Verzeichnis befinden, ist der Pfad jetzt '.' )
if [ ! -d ".git" ]; then
    echo "FEHLER: Dies ist kein Git-Repository. Bitte prüfen." >&2
    exit 1
fi

# --- Schritt 2: Der "Git-Anchor-Check" (P22 / V3.12) ---
echo "Verbinde mit SSoT (Git) und hole 'main' (Anker-Check)..."
git checkout main || git checkout master # Sicherstellen, dass ein Branch ausgecheckt ist
git pull origin main || git pull origin master # Holen des aktuellsten Ankers

# --- Schritt 3: Hotfix-Branch erstellen (basierend auf dem V3.11 Tag) ---
echo "Erstelle 'hotfix/V3.17-hardening' Branch (basierend auf V3.11 Tag)..."

# Sicherheits-Check: Lösche alten Branch, falls vorhanden
if git show-ref --quiet refs/heads/hotfix/V3.17-hardening; then
    echo "Info: Alter 'hotfix/V3.17-hardening' Branch wird gelöscht..."
    git branch -D hotfix/V3.17-hardening
fi

# Wir MÜSSEN vom Tag V3.11 branchen, da dies der letzte "funktionierende Stand" war
git checkout -b hotfix/V3.17-hardening V3.11

echo ""
echo "--- ERFOLGREICH ---"
echo "Sie befinden sich jetzt auf dem Branch: 'hotfix/V3.17-hardening'"
echo "Dies ist unsere #Arbeits-Basis für die V3.17-Härtung."
