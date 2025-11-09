#!/bin/bash
# V3.35 GENESIS TOOL (CONTEXT-PACKER EDITION)
# Erstellt nicht nur das Projekt, sondern auch den kompletten KI-Start-Kontext.

# [P16.2] History-Hygiene
set +o history

# --- KONFIGURATION ---
SSOT_REPO_URL="https://github.com/rh-ol/unser_FrameWork.git"

# --- HILFSFUNKTIONEN ---
print_header() { clear; echo -e "\033[1;34m== 🚀 V3.35 GENESIS (CONTEXT-PACKER) ==\033[0m\n"; }
print_step() { echo -e "\n\033[1;33m>>> SCHRITT $1/8: $2...\033[0m"; }
print_success() { echo -e "\033[1;32m✅ $1\033[0m"; }
print_error() { echo -e "\033[1;31m❌ FEHLER: $1\033[0m"; }

# --- SYSTEM ANALYZER (V3.35 Deep Scan) ---
analyze_system() {
    TARGET="$1"
    mkdir -p "$TARGET/config"
    echo "--- Starte Tiefenanalyse des Systems... ---"
    {
        echo "{"
        echo "  \"os\": \"$(uname -sr)\","
        echo "  \"hostname\": \"$(hostname)\","
        echo "  \"user\": \"$(whoami)\","
        echo "  \"shell\": \"$SHELL\","
        echo "  \"tools\": {"
        echo "    \"git\": \"$(git --version 2>/dev/null | head -n1)\","
        echo "    \"python3\": \"$(python3 --version 2>/dev/null | head -n1)\","
        echo "    \"node\": \"$(node --version 2>/dev/null | head -n1)\","
        echo "    \"docker\": \"$(docker --version 2>/dev/null | head -n1)\","
        echo "    \"tree\": \"$(tree --version 2>/dev/null | head -n1)\""
        echo "  },"
        echo "  \"hardware\": {"
        echo "    \"cores\": \"$(nproc 2>/dev/null || echo 'unknown')\","
        echo "    \"ram_free\": \"$(free -h 2>/dev/null | grep Mem | awk '{print $4}')\""
        echo "  }"
        echo "}"
    } > "$TARGET/config/system_profile.json"
}

# --- LEGACY ANALYZER (V3.35 Deep Scan) ---
analyze_legacy() {
    SRC="$1"
    TARGET="$2"
    mkdir -p "$TARGET/config"
    echo "--- Starte Tiefenanalyse des Legacy-Codes... ---"
    {
        echo "{"
        echo "  \"source_path\": \"$SRC\","
        echo "  \"structure\": \"$(tree -L 2 -d "$SRC" | base64 -w0)\","
        echo "  \"stats\": {"
        echo "    \"total_files\": $(find "$SRC" -type f | wc -l),"
        echo "    \"total_size\": \"$(du -sh "$SRC" | cut -f1)\","
        echo "    \"file_types\": \"$(find "$SRC" -maxdepth 3 -type f | grep -o '\.[^./]*$' | sort | uniq -c | sort -nr | tr '\n' ', ')\""
        echo "  }"
        echo "}"
    } > "$TARGET/config/legacy_profile.json"
}

# --- START ---
print_header

# 1. BASIS (Smart Selection V3.26 Revised)
print_step 1 8 "Basis-Pfad wählen"
SEARCH_RESULTS=$(find /mnt ~ -maxdepth 5 -name ".project_id" 2>/dev/null | sed 's|/[^/]*$||' | sed 's|/[^/]*$||' | sort | uniq)
OPTIONS=()
while IFS= read -r line; do if [ -n "$line" ]; then OPTIONS+=("$line"); fi; done <<< "$SEARCH_RESULTS"
CURRENT_DIR=$(pwd)
if [[ ! " ${OPTIONS[@]} " =~ " ${CURRENT_DIR} " ]]; then OPTIONS+=("$CURRENT_DIR"); fi
OPTIONS+=("Benutzerdefinierter Pfad...")

PS3="Wahl (Nummer): "
select OPT in "${OPTIONS[@]}"; do
    if [ "$OPT" == "Benutzerdefinierter Pfad..." ]; then read -e -p ">> Pfad: " BASE_DIR; break;
    elif [ -n "$OPT" ]; then BASE_DIR="$OPT"; break;
    else echo "❌ Ungültig."; fi
done
mkdir -p "$BASE_DIR"
BASE_DIR=$(cd "$BASE_DIR" && pwd)
print_success "Basis: $BASE_DIR"

# 2. PROJEKT-TYP
print_step 2 8 "Typ wählen"
echo "[1] Greenfield (Neu)"
echo "[2] Migration (Rewrite/Wrapper)"
read -e -p ">>> Wahl [1/2]: " PROJ_TYPE_NUM
PROJ_TYPE="greenfield"
if [ "$PROJ_TYPE_NUM" == "2" ]; then PROJ_TYPE="migration"; fi

# 3. NAME & QUELLE
print_step 3 8 "Konfiguration"
if [ "$PROJ_TYPE" == "migration" ]; then
    read -e -p ">>> Pfad zur Alt-Anwendung: " LEGACY_SOURCE
    if [ ! -e "$LEGACY_SOURCE" ]; then print_error "Quelle fehlt!"; exit 1; fi
fi
while true; do
    read -e -p ">>> NEUER Projektname (Ordner in $BASE_DIR/): " PROJ_NAME
    if [[ "$PROJ_NAME" == *"/"* ]] || [ -z "$PROJ_NAME" ]; then print_error "Ungültiger Name."; continue; fi
    FULL_PATH="$BASE_DIR/$PROJ_NAME"
    if [ -d "$FULL_PATH" ]; then print_error "Existiert bereits!"; continue; fi
    break
done

# 4. KLONEN
print_step 4 8 "Basis klonen"
if ! git clone --quiet --depth 1 "$SSOT_REPO_URL" "$FULL_PATH" 2>/dev/null; then
    read -s -p ">>> GitHub Token erforderlich: " GIT_TOKEN
    if ! git clone --quiet --depth 1 "${SSOT_REPO_URL/\/\//\/\/$GIT_TOKEN@}" "$FULL_PATH"; then
         print_error "Klonen gescheitert."; set -o history; exit 1
    fi
fi

# 5. ENTKOPPELN
print_step 5 8 "Entkoppeln"
cd "$FULL_PATH" || exit 1
rm -rf .git
git init --quiet

# 6. ANALYSE & IMPORT
print_step 6 8 "Analysieren & Importieren"
analyze_system "$FULL_PATH"
if [ "$PROJ_TYPE" == "migration" ]; then
    mkdir -p import
    cp -r "$LEGACY_SOURCE" import/
    analyze_legacy "$LEGACY_SOURCE" "$FULL_PATH"
fi

# 7. IDENTITÄT & METADATEN
print_step 7 8 "Verriegeln"
NEW_ID=$(uuidgen 2>/dev/null || date +%s)
echo "$NEW_ID" > .project_id
# Wir speichern den Typ für den Context-Packer
echo "$PROJ_TYPE" > .project_type

git add .
git commit --quiet -m "chore(genesis): V3.35 Project ($PROJ_TYPE) initialized"

# 8. CONTEXT-PACKER (DAS NEUE HERZSTÜCK)
print_step 8 8 "KI-Kontext packen (AI_START_CONTEXT.md)"
PACKED_FILE="$FULL_PATH/AI_START_CONTEXT.md"
{
    echo "# KI START KONTEXT [V3.35]"
    echo "## METADATEN"
    echo "* **Projekt-ID:** $NEW_ID"
    echo "* **Typ:** $PROJ_TYPE"
    echo "* **Pfad:** $FULL_PATH"
    echo ""
    echo "## 1. ZÜNDSCHLÜSSEL (BOOTSTRAPPER)"
    cat KI_BOOTSTRAP_PROMPT.md
    echo ""
    echo "## 2. SYSTEM-ANALYSE (LIVE)"
    echo '```json'
    cat config/system_profile.json
    echo '```'
    if [ -f "config/legacy_profile.json" ]; then
        echo ""
        echo "## 3. LEGACY-ANALYSE (BROWNFIELD)"
        echo '```json'
        cat config/legacy_profile.json
        echo '```'
    fi
} > "$PACKED_FILE"

# ABSCHLUSS
print_header
print_success "GENESIS ABGESCHLOSSEN"
echo "📂 Projekt: $FULL_PATH"
echo "📄 Kontext: $PACKED_FILE"
echo ""
echo -e "\033[1;33m>>> FINALER SCHRITT: Kopieren Sie den Inhalt von AI_START_CONTEXT.md in den neuen Chat!\033[0m"
echo "(Tipp: 'cat $PACKED_FILE' oder öffnen Sie es im Editor)"
set -o history
