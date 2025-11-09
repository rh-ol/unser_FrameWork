#!/bin/bash
# V3.34 GENESIS TOOL (UX HARDENED)
# Usage: /path/to/genesis.sh

# [P16.2] History-Hygiene
set +o history

# --- KONFIGURATION ---
SSOT_REPO_URL="https://github.com/rh-ol/unser_FrameWork.git"

# --- HILFSFUNKTIONEN (UX) ---
print_header() {
    clear
    echo -e "\033[1;34m===============================================\033[0m"
    echo -e "\033[1;32m   🚀 V3.34 GENESIS (SAFE UX MODE) 🚀\033[0m"
    echo -e "\033[1;34m===============================================\033[0m"
    echo ""
}
print_step() {
    echo -e "\n\033[1;33m>>> SCHRITT $1/$2: $3...\033[0m"
}
print_success() {
    echo -e "\033[1;32m✅ $1\033[0m"
}
print_error() {
    echo -e "\033[1;31m❌ FEHLER: $1\033[0m"
}

# --- START ---
print_header

# 1. BASIS-PFAD WAHL
print_step 1 7 "Basis-Pfad auswählen"
echo "🔍 Suche nach optimalen Standorten..."
SEARCH_RESULTS=$(find ~ /mnt -maxdepth 5 -name ".project_id" 2>/dev/null | sed 's|/[^/]*$||' | sed 's|/[^/]*$||' | sort | uniq)
OPTIONS=()
while IFS= read -r line; do if [ -n "$line" ]; then OPTIONS+=("$line"); fi; done <<< "$SEARCH_RESULTS"
CURRENT_DIR=$(pwd)
if [[ ! " ${OPTIONS[@]} " =~ " ${CURRENT_DIR} " ]]; then OPTIONS+=("$CURRENT_DIR"); fi
OPTIONS+=("Benutzerdefinierter Pfad...")

PS3="Ihre Wahl (Nummer): "
select OPT in "${OPTIONS[@]}"; do
    if [ "$OPT" == "Benutzerdefinierter Pfad..." ]; then
        read -e -p ">>> Basis-Pfad eingeben (Absoluter Pfad): " BASE_DIR
        break
    elif [ -n "$OPT" ]; then
        BASE_DIR="$OPT"
        break
    else
        echo "❌ Ungültig."
    fi
done
# Ensure Base Dir exists and is absolute
mkdir -p "$BASE_DIR"
BASE_DIR=$(cd "$BASE_DIR" && pwd)
print_success "Basis: $BASE_DIR"

# 2. PROJEKTNAME (Input-Hygiene Fix!)
print_step 2 7 "Projektnamen definieren"
while true; do
    read -e -p ">>> Wie soll der NEUE Projekt-Ordner heißen? (Nur Name, kein Pfad!): " PROJ_NAME
    # Check auf illegale Zeichen (Slashes)
    if [[ "$PROJ_NAME" == *"/"* ]]; then
        print_error "Der Name darf keine Slashes containen! Nur der Ordnername."
        continue
    fi
    if [ -z "$PROJ_NAME" ]; then
        print_error "Name darf nicht leer sein."
        continue
    fi
    FULL_PATH="$BASE_DIR/$PROJ_NAME"
    if [ -d "$FULL_PATH" ]; then
        print_error "Ziel '$FULL_PATH' existiert bereits!"
        # P27 Check: Ist es ein aktives Projekt?
        if [ -f "$FULL_PATH/.project_id" ]; then
             echo -e "\033[1;31m⚠️  ACHTUNG: Das ist bereits ein aktives Framework-Projekt!\033[0m"
             echo "ID: $(cat "$FULL_PATH/.project_id")"
        fi
        continue
    fi
    break
done
print_success "Ziel: $FULL_PATH"

# 3. PROJEKT-TYP
print_step 3 7 "Typ wählen"
echo "[1] Greenfield (Neu)"
echo "[2] Migration (Rewrite/Wrapper)"
read -e -p ">>> Wahl [1/2]: " PROJ_TYPE
LEGACY_SOURCE=""
if [ "$PROJ_TYPE" == "2" ]; then
    read -e -p ">>> Pfad zur Alt-Anwendung (Import): " LEGACY_SOURCE
    if [ ! -e "$LEGACY_SOURCE" ]; then
        print_error "Quelle nicht gefunden. Fahre ohne Import fort."
        LEGACY_SOURCE=""
    fi
fi

# 4. KLONEN
print_step 4 7 "Basis klonen (SSoT)"
if ! git clone --quiet --depth 1 "$SSOT_REPO_URL" "$FULL_PATH" 2>/dev/null; then
    echo "⚠️  Token erforderlich."
    read -s -p ">>> GitHub Token: " GIT_TOKEN
    echo ""
    AUTH_URL="${SSOT_REPO_URL/\/\//\/\/$GIT_TOKEN@}"
    if ! git clone --quiet --depth 1 "$AUTH_URL" "$FULL_PATH"; then
         print_error "Klonen gescheitert."
         set -o history; exit 1
    fi
fi
print_success "Basis geklont."

# 5. ENTKOPPELN & ANALYSE
print_step 5 7 "Entkoppeln & Analysieren"
cd "$FULL_PATH" || exit 1
rm -rf .git
git init --quiet

# Inline-Profiler (vereinfacht für UX)
mkdir -p config
echo "{\"os\":\"$(uname -sr)\", \"date\":\"$(date -u)\"}" > config/system_profile.json

if [ -n "$LEGACY_SOURCE" ]; then
    echo "--- Importiere Legacy-Code... ---"
    mkdir -p import
    cp -r "$LEGACY_SOURCE" import/
    echo "{\"source\":\"$LEGACY_SOURCE\", \"imported_at\":\"$(date -u)\"}" > config/legacy_profile.json
    print_success "Legacy importiert."
fi

# 6. IDENTITÄT (P27)
print_step 6 7 "Verriegeln (Identity Lock)"
NEW_ID=$(uuidgen 2>/dev/null || date +%s)
echo "$NEW_ID" > .project_id
git add .
git commit --quiet -m "chore(genesis): Project initialized (V3.34)"
print_success "ID gesetzt: $NEW_ID"

# 7. ABSCHLUSS
print_header
echo -e "\033[1;32m✅ GENESIS ERFOLGREICH ABGESCHLOSSEN\033[0m"
echo "📂 Pfad: $FULL_PATH"
echo "🔑 ID:   $NEW_ID"
echo ""
echo -e "\033[1;33m>>> NÄCHSTER SCHRITT (Kopieren & in neuen Chat einfügen):\033[0m"
echo "---------------------------------------------------"
cat KI_BOOTSTRAP_PROMPT.md
echo "---------------------------------------------------"
set -o history
