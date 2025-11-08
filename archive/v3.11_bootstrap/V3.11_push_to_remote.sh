#!/bin/bash
# V3.11 Git-Operator-Skript: Push to Remote (SSoT)
# Dieses Skript verbindet das lokale Repo mit dem zentralen Server.

echo "--- V3.11 'Push to Remote' Skript ---"

# Sicherheits-Check 1: Sind wir in einem Git-Repo?
if [ ! -d .git ]; then
    echo "FEHLER: Dies ist kein Git-Repository." >&2
    echo "Das sollte nach V3.11.2 nicht passieren. Bitte prüfen." >&2
    exit 1
fi

# Sicherheits-Check 2: Ist 'origin' bereits konfiguriert?
if git remote -v | grep -q "origin"; then
    echo "INFO: Remote 'origin' ist bereits konfiguriert."
    echo "Führe 'git push origin main --tags' aus..."
    git push origin main --tags
    echo "--- Push abgeschlossen. ---"
    exit 0
fi

echo ""
echo "###################################################################"
echo "BITTE ERSTELLEN SIE JETZT EIN LEERES REPOSITORY"
echo "auf Ihrem Git-Server (z.B. GitHub, GitLab)."
echo "WICHTIG: KEINE README, KEINE LIZENZ, KEIN .gitignore hinzufügen."
echo ""
echo "Kopieren Sie die SSH- (empfohlen) oder HTTPS-URL."
echo "###################################################################"
echo ""

# Interaktive Abfrage der URL
read -p "Bitte fügen Sie die Git-Remote-URL hier ein: " GIT_REMOTE_URL

# Sicherheits-Check 3: Wurde eine URL eingegeben?
if [ -z "$GIT_REMOTE_URL" ]; then
    echo "FEHLER: Keine URL eingegeben. Abbruch." >&2
    exit 1
fi

echo "Verbinde 'origin' mit: $GIT_REMOTE_URL"

# --- Der Finale Upload ---
# 1. Remote-Adresse hinzufügen
git remote add origin "$GIT_REMOTE_URL"

# 2. Den 'main' Branch pushen und als Upstream setzen
# (Git 2.x+ defaultet auf 'main', aber ältere könnten 'master' nutzen. 'main' ist wahrscheinlicher)
git push -u origin main

# 3. Den V3.11 "Funktionierenden Stand" Tag pushen
git push origin --tags

echo ""
echo "--- ERFOLGREICH ---"
echo "V3.11 Basis ('unser_FrameWork') wurde erfolgreich auf den zentralen Server gepusht."
echo "Die 'Single Source of Truth' (SSoT) ist jetzt etabliert."
