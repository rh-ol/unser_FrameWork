#!/bin/bash
# V3.28 TRUE UNIVERSAL GENESIS TOOL
# Startet Greenfield UND Brownfield Projekte aus der SSoT.
# Usage: curl -sL [URL] | bash

# [P16.2] History-Hygiene
set +o history

# --- KONFIGURATION ---
SSOT_REPO_URL="https://github.com/rh-ol/unser_FrameWork.git"

clear
echo "==============================================="
echo "   🚀 V3.28 TRUE UNIVERSAL GENESIS 🚀"
echo "==============================================="
echo ""

# 1. BASIS-PFAD WAHL (Smart Search)
echo "🔍 Suche nach optimalem Basis-Pfad..."
SEARCH_RESULTS=$(find ~ /mnt -maxdepth 5 -name ".project_id" 2>/dev/null | sed 's|/[^/]*$||' | sed 's|/[^/]*$||' | sort | uniq)
OPTIONS=()
while IFS= read -r line; do if [ -n "$line" ]; then OPTIONS+=("$line"); fi; done <<< "$SEARCH_RESULTS"
CURRENT_DIR=$(pwd)
if [[ ! " ${OPTIONS[@]} " =~ " ${CURRENT_DIR} " ]]; then OPTIONS+=("$CURRENT_DIR"); fi
OPTIONS+=("Benutzerdefinierter Pfad...")

echo "Gefundene Basis-Pfade:"
PS3="Ihre Wahl (Nummer): "
select OPT in "${OPTIONS[@]}"; do
    if [ "$OPT" == "Benutzerdefinierter Pfad..." ]; then
        read -e -p ">>> Basis-Pfad eingeben: " BASE_DIR
        break
    elif [ -n "$OPT" ]; then
        BASE_DIR="$OPT"
        break
    else
        echo "❌ Ungültig."
    fi
done
if [ ! -d "$BASE_DIR" ]; then mkdir -p "$BASE_DIR"; fi

# 2. PROJEKT-TYP & NAME
echo ""
echo "-----------------------------------------------"
echo "Welche Art von Projekt starten wir?"
echo "[1] Greenfield (Komplett neu)"
echo "[2] Migration (Rewrite/Wrapper eines Altsystems)"
echo "-----------------------------------------------"
read -e -p ">>> Ihre Wahl [1/2]: " PROJ_TYPE

LEGACY_SOURCE=""
if [ "$PROJ_TYPE" == "2" ]; then
    read -e -p ">>> Pfad zur Alt-Anwendung/Skript (wird importiert): " LEGACY_SOURCE
    if [ ! -e "$LEGACY_SOURCE" ]; then
        echo "⚠️ WARNUNG: Quelle '$LEGACY_SOURCE' nicht gefunden. Fahre ohne Import fort."
        LEGACY_SOURCE=""
    fi
fi

echo ""
read -e -p ">>> NEUER Projektname (Zielordner): " PROJ_NAME
if [ -z "$PROJ_NAME" ]; then echo "❌ Abbruch."; set -o history; exit 1; fi
FULL_PATH="$BASE_DIR/$PROJ_NAME"
if [ -d "$FULL_PATH" ]; then echo "❌ Existiert bereits!"; set -o history; exit 1; fi

# 3. KLONEN & ENTKOPPELN
echo ""
echo "--- Klonen der Basis (V3.28)... ---"
if ! git clone --quiet "$SSOT_REPO_URL" "$FULL_PATH" 2>/dev/null; then
    echo "⚠️ Standard-Klon nicht möglich. Token erforderlich:"
    read -s GIT_TOKEN
    AUTH_URL="${SSOT_REPO_URL/\/\//\/\/$GIT_TOKEN@}"
    if ! git clone --quiet "$AUTH_URL" "$FULL_PATH"; then
         echo "❌ KRITISCHER FEHLER: Klonen gescheitert."
         set -o history; exit 1
    fi
fi

cd "$FULL_PATH" || exit 1
rm -rf .git
git init --quiet

# 4. MIGRATIONS-IMPORT (Falls gewählt)
if [ -n "$LEGACY_SOURCE" ]; then
    echo "--- Importiere Legacy-Code... ---"
    mkdir -p import
    cp -r "$LEGACY_SOURCE" import/
    echo "✅ Legacy-Code nach 'import/' kopiert."
fi

# 5. IDENTITÄT & INITIAL COMMIT
git add .
git commit --quiet -m "chore(genesis): Project born from V3.28 Framework"
NEW_ID=$(uuidgen 2>/dev/null || date +%s)
echo "$NEW_ID" > .project_id
git add .project_id
git commit --quiet --amend --no-edit

# 6. ABSCHLUSS
clear
echo "==============================================="
echo "✅ V3.28 GENESIS ERFOLGREICH!"
echo "==============================================="
echo "📂 Projekt:  $FULL_PATH"
echo "🔑 ID:       $NEW_ID"
if [ -n "$LEGACY_SOURCE" ]; then
    echo "📦 Legacy:   In 'import/' gesichert."
fi
echo ""
echo ">>> NÄCHSTER SCHRITT (Kopieren & in neuen KI-Chat einfügen):"
echo "---------------------------------------------------"
cat KI_BOOTSTRAP_PROMPT.md
echo "---------------------------------------------------"
set -o history
