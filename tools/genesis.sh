#!/bin/bash
# V3.29 ANALYTIC GENESIS TOOL
# Startet Projekte und analysiert die Umgebung automatisch.
# Usage: curl -sL [URL] | bash

# [P16.2] History-Hygiene
set +o history

# --- KONFIGURATION ---
SSOT_REPO_URL="https://github.com/rh-ol/unser_FrameWork.git"

# --- HILFSFUNKTION: SYSTEM PROFILER (Inline) ---
generate_system_profile() {
    TARGET_FILE="$1/config/system_profile.json"
    mkdir -p "$(dirname "$TARGET_FILE")"
    echo "{" > "$TARGET_FILE"
    echo "  \"os\": \"$(uname -sr)\"," >> "$TARGET_FILE"
    echo "  \"bash\": \"$BASH_VERSION\"," >> "$TARGET_FILE"
    echo "  \"git\": \"$(git --version | awk '{print $3}')\"," >> "$TARGET_FILE"
    echo "  \"date\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"" >> "$TARGET_FILE"
    echo "}"
    echo "✅ System-Profil erstellt: config/system_profile.json"
}

# --- HILFSFUNKTION: LEGACY PROFILER (Inline) ---
generate_legacy_profile() {
    SOURCE="$1"
    TARGET_FILE="$2/config/legacy_profile.json"
    mkdir -p "$(dirname "$TARGET_FILE")"
    echo "{" > "$TARGET_FILE"
    echo "  \"source_path\": \"$SOURCE\"," >> "$TARGET_FILE"
    echo "  \"file_count\": $(find "$SOURCE" -type f | wc -l)," >> "$TARGET_FILE"
    echo "  \"total_size\": \"$(du -sh "$SOURCE" | cut -f1)\"," >> "$TARGET_FILE"
    echo "  \"file_types\": \"$(find "$SOURCE" -maxdepth 2 -type f | sed 's/.*\.//' | sort | uniq | tr '\n' ',')\"" >> "$TARGET_FILE"
    echo "}"
    echo "✅ Legacy-Profil erstellt: config/legacy_profile.json"
}

clear
echo "==============================================="
echo "   🚀 V3.29 ANALYTIC GENESIS 🚀"
echo "==============================================="
echo ""

# 1. BASIS-PFAD WAHL (Smart Selection V3.26)
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

# 2. VORSCHAU
echo ""
echo "📂 Inhalt von: $BASE_DIR"
if command -v tree &> /dev/null; then tree -d -L 1 "$BASE_DIR"; else ls -d "$BASE_DIR"/*/ 2>/dev/null || echo "(Leer)"; fi
echo ""

# 3. PROJEKT-TYP
echo "-----------------------------------------------"
echo "Welche Art von Projekt starten wir?"
echo "[1] Greenfield (Komplett neu)"
echo "[2] Migration (Rewrite/Wrapper eines Altsystems)"
echo "-----------------------------------------------"
read -e -p ">>> Ihre Wahl [1/2]: " PROJ_TYPE

LEGACY_SOURCE=""
if [ "$PROJ_TYPE" == "2" ]; then
    read -e -p ">>> Pfad zur Alt-Anwendung (wird analysiert & importiert): " LEGACY_SOURCE
    if [ ! -e "$LEGACY_SOURCE" ]; then
        echo "⚠️ WARNUNG: Quelle nicht gefunden. Abbruch empfohlen."
        read -e -p "Trotzdem fortfahren? [j/n]: " CONT
        if [[ ! "$CONT" =~ ^[jJ]$ ]]; then exit 1; fi
        LEGACY_SOURCE=""
    fi
fi

echo ""
read -e -p ">>> NEUER Projektname (Zielordner): " PROJ_NAME
if [ -z "$PROJ_NAME" ]; then echo "❌ Abbruch."; set -o history; exit 1; fi
FULL_PATH="$BASE_DIR/$PROJ_NAME"
if [ -d "$FULL_PATH" ]; then echo "❌ Existiert bereits!"; set -o history; exit 1; fi

# 4. KLONEN
echo "--- Phase 1: Basis klonen... ---"
if ! git clone --quiet "$SSOT_REPO_URL" "$FULL_PATH" 2>/dev/null; then
    echo "⚠️ Token erforderlich:"
    read -s GIT_TOKEN
    AUTH_URL="${SSOT_REPO_URL/\/\//\/\/$GIT_TOKEN@}"
    if ! git clone --quiet "$AUTH_URL" "$FULL_PATH"; then echo "❌ KRITISCHER FEHLER: Klonen gescheitert."; set -o history; exit 1; fi
fi

cd "$FULL_PATH" || exit 1
rm -rf .git
git init --quiet

# 5. ANALYSE & IMPORT (V3.29 NEU)
echo "--- Phase 2: Analyse & Initialisierung... ---"
generate_system_profile "."
if [ -n "$LEGACY_SOURCE" ]; then
    mkdir -p import
    cp -r "$LEGACY_SOURCE" import/
    generate_legacy_profile "$LEGACY_SOURCE" "."
fi

# 6. IDENTITÄT & COMMIT
git add .
git commit --quiet -m "chore(genesis): Project born from V3.29 Analytic Framework"
NEW_ID=$(uuidgen 2>/dev/null || date +%s)
echo "$NEW_ID" > .project_id
git add .project_id
git commit --quiet --amend --no-edit

# 7. ABSCHLUSS
clear
echo "==============================================="
echo "✅ V3.29 GENESIS ERFOLGREICH!"
echo "==============================================="
echo "📂 Projekt:  $FULL_PATH"
echo "🔑 ID:       $NEW_ID"
if [ -f "config/system_profile.json" ]; then echo "📊 Analyse:  System-Profil erstellt."; fi
if [ -f "config/legacy_profile.json" ]; then echo "🏛️ Analyse:  Legacy-Profil erstellt."; fi
echo ""
echo ">>> NÄCHSTER SCHRITT (Zündschlüssel kopieren):"
echo "---------------------------------------------------"
cat KI_BOOTSTRAP_PROMPT.md
echo "---------------------------------------------------"
set -o history
