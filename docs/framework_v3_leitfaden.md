# Architektur-Leitfaden: Robustes Automatisierungs-Framework (V3.17)

## Einführung
Dies ist der technische #Bauplan für das V3.17-Framework. Es definiert alle 28 #Prinzipien und die #Architektur, die durch den `KI_BOOTSTRAP_PROMPT.md` (P0) initiiert wird. Dieses Dokument ist die "Single Source of Truth" für das Design des Ökosystems.

---

## Phase 0: Der KI-Geführte Projekt-Lebenszyklus

Diese Phase definiert den #DevOps-Zyklus, die #Entwickler-Erfahrung (DX) und den #Architektur-Workflow.

### Prinzip 0: Der "One Shot" Bootstrapper (V3.8+ Workflow)
* **Problem:** Ein neuer Entwickler weiß nicht, wie er anfangen soll.
* **Lösung:** Ein einziger, atomarer Start-Workflow, gesteuert durch den `KI_BOOTSTRAP_PROMPT.md`.
* **Sub-Prinzip (P0.5):** Konversationelles Commit Kit für atomare Git-Updates.

### Prinzip 16: Testdaten-Generierung & History-Hygiene (QA & Security)
* **P16.1 (QA):** KI generiert Testdaten (`testdata_generator.sh`).
* **P16.2 (Security):** Sensible Terminal-Befehle MÜSSEN durch `set +o history` gekapselt werden.

### Prinzip 17: CI/CD Pipeline-Generierung (Deployment-Setup)
* KI generiert `ci_cd_pipeline.yml` für automatisierte Tests/Deployments.

### Prinzip 18: "IntelliSense"-Architektur (Selbst-Dokumentation)
* Code muss durch strenge Typisierung und JSDoc seine eigene Dokumentation sein.

### Prinzip 19: Anforderungs-Management (#Reusability)
* Jede Entwicklung beginnt mit einer Anforderung (`REQ-001`). Anforderungen werden in wiederverwendbaren Sets gruppiert.

### Prinzip 22: Der #Generelle_Software_Development_Prozess (SDP / Git-Flow)
* Wir nutzen einen KI-geführten **GitHub-Flow**:
    1.  **#Branch:** Immer auf isolierten Branches arbeiten.
    2.  **#Verify:** Lokal testen (P0 Abnahmetest).
    3.  **#Review:** Pull Request (PR) und menschlicher Review des Diffs.
    4.  **#Merge & #Tag:** Nur stabile Stände gelangen nach `main`.

### Prinzip 23: #CleanCode & #KISS
* **KISS:** Einfachste, robuste Lösung bevorzugen.
* **DRY:** Wiederholungen vermeiden (Core-Paket P21).
* **Archivierung:** Veraltete Skripte nicht löschen, sondern nach `archive/` verschieben (Transparenz P4).

### Prinzip 24: Zwingende Fehler-Integrität
* Erkannte #Bugs haben sofortige Priorität. Der Prozess wird "eingefroren", bis der Bug behoben ist.

### Prinzip 25: Automatische Dokumentations-Pflicht
* Jede strukturelle Änderung muss *sofort* von der KI im Leitfaden dokumentiert werden.

### Prinzip 26: Standort-Bewusstsein (Location Awareness)
* Skripte müssen ihren eigenen Standort relativ zum Projekt-Root (`.project_id`) selbst finden.

### Prinzip 27: Projekt-Verriegelung (Identity Lock)
* Jedes Skript prüft zwingend die `.project_id`, um Ausführung im falschen Projekt zu verhindern.

### Prinzip 28: Kontext-Verriegelung (Branch Awareness)
* Kritische Skripte müssen prüfen, auf welchem #Branch sie laufen (z.B. darf ein Dev-Skript nicht auf `main` laufen).

---

## Phase 1: Die Kern-Architektur (Das "Worker-Pattern")
### Prinzip 5: Das "Worker-Interface-Pattern" (Dependency Injection)

---

## Phase 2: Das Fundament (Die "Service"-Implementierungen)
* **P1:** Zentralisierte Konfiguration
* **P2:** Sicheres Secrets Management
* **P3:** Physische Umgebungs-Trennung
* **P4:** Persistentes, Strukturiertes Logging
* **P12:** Aktive Alarmierung

---

## Phase 3: Die Architektur (Die "Worker"-Implementierung)
* **P6:** Idempotentes Design
* **P7:** "Dry Run" / Test-Modus

---

## Phase 4: Die Sicherheitsnetze
* **P8:** Sichere Stapelverarbeitung
* **P9:** Interner Sicherheits-Timer
* **P10:** Transaktionale Fehlerbehandlung
* **P11:** Manueller Korrektur-Mechanismus

---

## Phase 5: Die System-Wartung
* **P13:** Proaktives Health-Monitoring
* **P14:** Log-Rotation & Archivierung
* **P15:** Data "Garbage Collection"

---

## Phase 6: Das Enterprise-Ökosystem
* **P20:** Asynchrone Choreografie (Events)
* **P21:** Zentrales Framework-Core-Paket (#SoS)
