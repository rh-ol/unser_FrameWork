#!/bin/bash
# V3.36 CONTEXT PACKER TOOL (REUSABLE)
# Usage: tools/context_packer.sh [TARGET_DIR]
# Default TARGET_DIR is '.' (current project)

set -euo pipefail
IFS=$'\n\t'

# --- KONFIGURATION ---
TARGET_DIR="${1:-.}"  # P19: Parameter für Wiederverwendbarkeit
OUTPUT_FILE="$(pwd)/PROJECT_CONTEXT.md" # Output immer im Aufruf-Verzeichnis
IGNORE_DIRS=(".git" "node_modules" "venv" "__pycache__" "archive")
IGNORE_FILES=("*.lock" "*.zip" "*.tar.gz" "*.png" "*.jpg" "*.pdf" "PROJECT_CONTEXT.md")

# --- VALIDIERUNG ---
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ FEHLER: Zielverzeichnis '$TARGET_DIR' existiert nicht."
    exit 1
fi

# --- MAIN ---
echo "--- V3.36 Context Packer ---"
echo "Target: $TARGET_DIR"
echo "Output: $OUTPUT_FILE"

rm -f "$OUTPUT_FILE"
touch "$OUTPUT_FILE"

# 1. Header
{
    echo "# CONTEXT SNAPSHOT"
    echo "* **Date:** $(date)"
    echo "* **Target:** $(abspath "$TARGET_DIR" 2>/dev/null || echo "$TARGET_DIR")"
    echo ""
    echo "## STRUCTURE"
    echo '```text'
    if command -v tree &> /dev/null; then
        tree -a -I '.git|node_modules|venv|__pycache__|archive' "$TARGET_DIR"
    else
        find "$TARGET_DIR" -maxdepth 3 -not -path '*/.*'
    fi
    echo '```'
    echo ""
    echo "## CONTENTS"
    echo ""
} >> "$OUTPUT_FILE"

# 2. Content Loop
FIND_CMD="find \"$TARGET_DIR\" -type f"
for dir in "${IGNORE_DIRS[@]}"; do FIND_CMD+=" -not -path '*/$dir/*'"; done
for file in "${IGNORE_FILES[@]}"; do FIND_CMD+=" -not -name '$file'"; done

eval "$FIND_CMD" | sort | while read -r file; do
    if file "$file" | grep -q "text"; then
        echo "📦 Packe: $file"
        {
            echo "### FILE: $file"
            echo '```'
            cat "$file"
            echo ""
            echo '```'
            echo ""
        } >> "$OUTPUT_FILE"
    fi
done

echo "✅ FERTIG: $OUTPUT_FILE ($(du -h "$OUTPUT_FILE" | cut -f1))"
