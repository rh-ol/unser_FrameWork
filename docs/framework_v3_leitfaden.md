# Architektur-Leitfaden: Robustes Automatisierungs-Framework (V3.21)

## Einführung
Dies ist der technische #Bauplan für das V3.21-Framework. Es definiert alle 31 #Prinzipien und die #Architektur, die durch den `KI_BOOTSTRAP_PROMPT.md` (P0) initiiert wird.

---

## Phase 0: Der KI-Geführte Projekt-Lebenszyklus

### Prinzip 0: Der "One Shot" Bootstrapper (V3.8+ Workflow)
* Ein einziger, atomarer Start-Workflow (`KI_BOOTSTRAP_PROMPT.md`).
* **P0.5:** Konversationelles Commit Kit.

### Prinzip 16: Testdaten & History-Hygiene (QA & Security)
* **P16.1 (QA):** KI generiert Testdaten.
* **P16.2 (Security):** `set +o history` Kapselung.

### Prinzip 17: CI/CD Pipeline-Generierung
* Automatisierte Tests und Deployments (`ci_cd_pipeline.yml`).

### Prinzip 18: "IntelliSense"-Architektur
* Selbst-dokumentierender Code (Type-Safety, JSDoc).

### Prinzip 19: Anforderungs-Management (#Reusability)
* Strukturierte Anforderungen (`REQ-001`), gruppiert in Sets.

### Prinzip 22: Der #Generelle_Software_Development_Prozess (Git-Flow)
* **#Branch** -> **#Verify** (lokal) -> **#Review** (PR) -> **#Merge & #Tag** (main).

### Prinzip 23: #CleanCode & #KISS
* Einfachheit, DRY, und Archivierung statt Löschen.

### Prinzip 24: Zwingende Fehler-Integrität
* Bugs haben Vorfahrt. Prozess-Freeze bei Fehlern.

### Prinzip 25: Automatische Dokumentations-Pflicht
* Sofortige Nachdokumentation aller strukturellen Änderungen.

### Prinzip 26: Standort-Bewusstsein (Location Awareness)
* Skripte finden ihren Root-Pfad (`.project_id` basiert).

### Prinzip 27: Projekt-Verriegelung (Identity Lock)
* Zwingender Check der `.project_id` vor Ausführung.

### Prinzip 28: Kontext-Verriegelung (Branch Awareness)
* Kritische Skripte prüfen den erlaubten Git-Branch.

### Prinzip 29: Sprach-Stabilität (Locale Stability)
* Projektsprache ([DE]/[EN]) wird initial fixiert.

### Prinzip 30: Interaktions-Effizienz (Lean Interaction)
* Skripte sind "Quiet by Default" mit standardisiertem Ergebnis-Block.

### Prinzip 31 (NEU V3.21): KVP & Die "Lean Architect" Checkliste
* **Problem:** Stillstand ist Rückschritt. Lösungen können unnötig komplex sein.
* **Lösung (KVP):** Kontinuierliche Verbesserung ist Pflicht für Architekt & KI.
* **Checkliste:** Die KI muss jede Lösung *intern* prüfen, bevor sie präsentiert wird:
    1.  **Is it Lean?** (Interaktionen minimiert?)
    2.  **Is it Clean?** (P23 eingehalten?)
    3.  **Is it Robust?** (P26-P28 integriert?)

---

## Phase 1: Die Kern-Architektur (Worker-Pattern)
* **P5:** Worker-Interface-Pattern (DI).

---

## Phase 2: Das Fundament (Services)
* **P1:** Config. **P2:** Secrets. **P3:** Trennung. **P4:** Logging. **P12:** Alerting.

---

## Phase 3: Die Architektur (Worker-Implementierung)
* **P6:** Idempotenz. **P7:** Dry Run.

---

## Phase 4: Die Sicherheitsnetze (Worker-Schleife)
* **P8:** Batching. **P9:** Timeout-Schutz. **P10:** Try/Catch Item-Isolation. **P11:** Re-Queue.

---

## Phase 5: Die System-Wartung
* **P13:** Health-Monitoring. **P14:** Log-Rotation. **P15:** Data GC.

---

## Phase 6: Das Enterprise-Ökosystem
* **P20:** Asynchrone Choreografie. **P21:** Zentrales Core-Paket.
