#!/bin/bash
# V3.11 (P22) Git-Operator-Skript: Initial Commit
# Führen Sie dieses Skript in Ihrem Terminal aus.

echo "--- Starte V3.11 Initial Commit ---"

# 1. Prüfen, ob Git installiert ist
if ! command -v git &> /dev/null; then
    echo "FEHLER: Git ist nicht installiert. Bitte installieren Sie Git." >&2
    exit 1
fi

# 2. Repository initialisieren
git init
echo "Git-Repository initialisiert."

# 3. Alle 10 Artefakte hinzufügen (inkl. Unterordner)
git add .
echo "Alle 10 V3.11-Artefakte (Bootstrapper, /docs, /testdata, .gitignore) hinzugefügt."

# 4. Initialer Commit
git commit -m "feat(framework): Initial commit of V3.11 ecosystem base"
echo "Initialer Commit erstellt."

# 5. Tag V3.11 (Der "funktionierende Stand")
git tag -a V3.11 -m "Initial release of the V3.11 Robust Automation Framework"
echo "Tag V3.11 (funktionierender Stand) erfolgreich gesetzt."

echo "---"
echo "V3.11 BASIS ERFOLGREICH IN GIT GESICHERT."
echo "Sie können jetzt 'git remote add origin [URL]' und 'git push origin main --tags' ausführen."
