# Architektur-Leitfaden: Robustes Automatisierungs-Framework (V3.36)

## Einführung
Dies ist der technische #Bauplan für das V3.36-Framework. Es definiert alle 34 #Prinzipien und die #Architektur.

---

## Phase 0: Der KI-geführte Projekt-Lebenszyklus & Tooling

### Prinzip 0: Der "Universelle Ursprung" (Genesis)
* `tools/genesis.sh` ist der universelle Startpunkt für neue Projekte (Greenfield & Brownfield).

### Prinzip 0.1 (NEU V3.36): Der "Kontext-Packer"
* **Problem:** KI hat keinen direkten Zugriff auf das Dateisystem.
* **Lösung:** `tools/context_packer.sh [PFAD]` erstellt einen vollständigen Markdown-Snapshot (`PROJECT_CONTEXT.md`) eines beliebigen Verzeichnisses für die KI-Analyse.

### Prinzip 16: Testdaten & History-Hygiene (QA & Security)
* **P16.1:** KI generiert Testdaten.
* **P16.2:** Sensible Befehle müssen mit `set +o history` gekapselt werden.

### Prinzip 17: CI/CD Pipeline-Generierung
* Automatisierte Tests und Deployments.

### Prinzip 18: "IntelliSense"-Architektur
* Selbst-dokumentierender Code.

### Prinzip 19: Anforderungs-Management (#Wiederverwendbarkeit)
* Strukturierte Anforderungen. Tools müssen wiederverwendbar sein (Parameter statt Hardcoding).

### Prinzip 22: Der #Generelle_Software_Entwicklungs-Prozess (Git-Flow)
* Branch -> Verify -> Review -> Merge & Tag.

### Prinzip 23: #SaubererCode & #KISS
* Einfachheit, DRY, Archivierung.

### Prinzip 24: Zwingende Fehler-Integrität
* Bugs stoppen Features.

### Prinzip 25: Automatische Dokumentations-Pflicht
* Jede Änderung muss sofort dokumentiert werden.

### Prinzip 26: Standort-Bewusstsein
* Skripte finden ihren Root-Pfad selbst.

### Prinzip 27: Projekt-Verriegelung
* `.project_id` Check ist zwingend.

### Prinzip 28: Kontext-Verriegelung
* Kritische Skripte prüfen den Git-Branch.

### Prinzip 29: Sprach-Stabilität
* Projektsprache ist fixiert ([DE]).

### Prinzip 30: Interaktions-Effizienz
* "Quiet by Default" Skripte.

### Prinzip 31: KVP & Die "Lean Architect" Checkliste
* Ständige Hinterfragung durch die KI (Lean? Clean? Robust? Documented?).

### Prinzip 32: Der KI-Gedächtnis-Kristall
* `AI_MEMORY.md` sichert den Kontext zwischen Sessions.

### Prinzip 33: Die Reflexions-Chronik
* `REFLECTION_LOG.md` speichert historische Entscheidungen.

### Prinzip 34 (NEU V3.36): Zwingende Planungs-Freigabe
* **Regel:** Bevor Code generiert wird, muss der Architekt den Masterplan freigeben (Checkliste).

---

## Phase 1-6: Kern-Architektur
*(Detaillierte Prinzipien P1-P15, P20-P21 siehe Code/Historie)*
