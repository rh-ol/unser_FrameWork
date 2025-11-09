# Architektur-Leitfaden: Robustes Automatisierungs-Framework (V3.32)

## Einführung
Dies ist der technische #Bauplan für das V3.28-Framework. Es definiert alle 31 #Prinzipien und die #Architektur, die durch das zentrale Werkzeug `tools/genesis.sh` initiiert wird. Dieses Dokument ist die einzige Quelle der Wahrheit (SSoT) für das Design des Ökosystems.

---

## Phase 0: Der KI-geführte Projekt-Lebenszyklus

### Prinzip 0: Der "Universelle Ursprung" (Genesis V3.28+ Workflow)
* **Problem:** Aller Anfang ist schwer (Henne-Ei-Problem bei neuen Projekten).
* **Lösung:** Das `tools/genesis.sh` Skript ist der universelle Einstiegspunkt für alles.
* **Funktionen (V3.28):**
    * **Intelligente Auswahl:** Findet automatisch die passenden Basis-Pfade für neue Projekte.
    * **Grüne Wiese (Greenfield):** Startet komplett neue, leere Projekte.
    * **Bestandsbau (Brownfield Migration):** Importiert existierenden Code automatisch in einen `import/` Ordner zur Weiterverarbeitung.
    * **Entkopplung:** Löscht die Git-Historie der Basis und initialisiert das neue Projekt sauber.
    * **Identität:** Setzt automatisch eine eindeutige Projekt-ID (`.project_id`).

### Prinzip 16: Testdaten & History-Hygiene (QA & Sicherheit)
* **P16.1 (Qualitätssicherung):** Die KI generiert Skripte zur Erzeugung von Testdaten (`testdata_generator.sh`).
* **P16.2 (Sicherheit):** Sensible Terminal-Befehle MÜSSEN durch `set +o history` (vorher) und `set -o history` (nachher) gekapselt werden, damit sie nicht in der Befehlshistorie landen.

### Prinzip 17: CI/CD Pipeline-Generierung
* Automatisierung von Tests und Bereitstellungen (z.B. via `ci_cd_pipeline.yml`).

### Prinzip 18: "IntelliSense"-Architektur (Selbstdokumentation)
* Der Code muss durch strenge Typisierung und Kommentare (z.B. JSDoc) seine eigene Dokumentation sein, damit die Entwicklungsumgebung (IDE) helfen kann.

### Prinzip 19: Anforderungs-Management (#Wiederverwendbarkeit)
* Jede Entwicklung beginnt mit einer klar definierten Anforderung (`REQ-001`). Anforderungen werden in wiederverwendbaren Gruppen (Sets) gebündelt.

### Prinzip 22: Der #Generelle_Software_Entwicklungs-Prozess (Git-Flow)
* Wir nutzen einen von der KI geführten **GitHub-Flow**:
    1.  **#Verzweigen (Branch):** Immer auf isolierten Arbeitskopien (Branches) arbeiten, niemals direkt auf der Hauptlinie.
    2.  **#Verifizieren (Verify):** Lokal testen (P0 Abnahmetest), bevor Änderungen geteilt werden.
    3.  **#Überprüfen (Review):** Änderungen via Pull Request (PR) durch den Architekten prüfen lassen (Diff-Sicht).
    4.  **#Zusammenführen & Markieren (Merge & Tag):** Nur stabile Stände gelangen in die Hauptlinie (`main`) und werden mit einer Versionsnummer versehen.

### Prinzip 23: #SaubererCode & #KISS
* **Einfachheit (KISS):** Die einfachste, robuste Lösung ist immer die beste.
* **Wiederholungen vermeiden (DRY):** Gemeinsamer Code gehört in das Kern-Paket (P21).
* **Archivierung statt Löschen:** Veraltete Skripte werden nicht gelöscht, sondern in einen dokumentierten `archive/` Ordner verschoben, um die Nachvollziehbarkeit (P4) zu sichern.

### Prinzip 24: Zwingende Fehler-Integrität
* Erkannte #Fehler (Bugs) haben sofortige Priorität vor neuer #Feature-Planung. Der Prozess wird "eingefroren", bis der Fehler behoben ist.

### Prinzip 25: Automatische Dokumentations-Pflicht
* Jede strukturelle Änderung am Framework muss *sofort und automatisch* von der KI in diesem Leitfaden nachgezogen werden.

### Prinzip 26: Standort-Bewusstsein
* Skripte müssen selbstständig erkennen, wo sie liegen (relativ zum Projekt-Root), um Ausführungsfehler zu vermeiden.

### Prinzip 27: Projekt-Verriegelung (Identitäts-Check)
* Jedes Skript muss zwingend die `.project_id` prüfen, um eine Ausführung im falschen Projektordner zu verhindern.

### Prinzip 28: Kontext-Verriegelung (Branch-Check)
* Kritische Skripte müssen prüfen, auf welcher Arbeitskopie (Branch) sie laufen (z.B. darf ein Entwickler-Skript nicht auf der Hauptlinie `main` laufen).

### Prinzip 29: Sprach-Stabilität
* Die Projektsprache ([DE]/[EN]) wird initial festgelegt und muss danach konsequent beibehalten werden.

### Prinzip 30: Interaktions-Effizienz (Schlanke Interaktion)
* Skripte sind standardmäßig "still" (wenig Output) und enden mit einem standardisierten Ergebnis-Block für die KI.

### Prinzip 31: KVP & Die "Lean Architect" Checkliste
### Prinzip 32 (NEU V3.30): Der KI-Gedächtnis-Kristall
* **Problem:** KI verliert Kontext zwischen Sessions (Amnesie).
* **Lösung:** `AI_MEMORY.md` speichert Status, Regeln & Backlog in der SSoT. Muss bei jedem Start geladen werden.
* Ständige Hinterfragung durch die KI vor jeder Ausgabe: Ist es schlank? Ist es sauber? Ist es robust? Ist es dokumentiert?

---

## Phase 1-6: Kern-Architektur & Ökosystem
*(Siehe detaillierte Prinzipien P1-P15, P20-P21 in früheren Versionen oder direkt im Code)*
