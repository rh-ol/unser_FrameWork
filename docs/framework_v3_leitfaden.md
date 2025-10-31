# Architektur-Leitfaden: Robustes Automatisierungs-Framework (V3.11)

## Einführung
Dies ist der technische #Bauplan für das V3.11-Framework. Es definiert alle 22 #Prinzipien und die #Architektur, die durch den `KI_BOOTSTRAP_PROMPT.md` (P0) initiiert wird. Dieses Dokument ist die "Single Source of Truth" für das Design des Ökosystems.

---

## Phase 0: Der KI-Geführte Projekt-Lebenszyklus (P0, P16, P17, P18, P19, P22)

Diese Phase definiert den #DevOps-Zyklus, die #Entwickler-Erfahrung (DX) und den #Architektur-Workflow (P22).

### Prinzip 0: Der "One Shot" Bootstrapper (V3.8+ Workflow)
* **Problem:** Ein neuer Entwickler weiß nicht, wie er anfangen soll, welche Werkzeuge er braucht oder wie er die #Umgebung (Environment) analysiert.
* **Lösung (V3.8):** Ein einziger, atomarer Start-Workflow, gesteuert durch den `KI_BOOTSTRAP_PROMPT.md (V3.11)`.
* **Workflow:**
    1.  **Start (P0.1):** Der Entwickler startet einen neuen Chat und fügt den `KI_BOOTSTRAP_PROMPT.md` (V3.11) ein.
    2.  **Profiler-Generierung (P0.2):** Die KI (im neuen Chat) erkennt `SITUATION 1` und generiert *sofort* das `system_profiler.sh` Skript, um die #Umgebungs-Analyse zu erzwingen.
    3.  **Analyse (P0.3):** Der Entwickler führt den Profiler aus und fügt das resultierende `system_profile.json` in den Chat ein.
    4.  **Auswahl (P0.4):** Die KI erkennt `SITUATION 2`, analysiert das JSON und stellt *dann* die "Drei-Optionen-Abfrage" (Greenfield, Wrapper, Rewrite).
* **Sub-Prinzip: Konversationelles Commit Kit (P0.5):** Nach Abschluss einer Entwicklungs-Iteration (`REQ-001`) bittet der Entwickler die KI, einen "Commit Kit" (P0) vorzubereiten. Die KI generiert Updates für `version.json`, `CHANGELOG.md` und ein `commit_helper.sh` Skript, um den #Git-Commit zu atomisieren.

### Prinzip 16: Testdaten-Generierung (QA-Setup)
* **Implementierung:** Die KI ist ein "QA-Partner" (P16). Der Entwickler bittet die KI ("Bitte generiere 10 Mock-Rechnungen (P16)"), und die KI erstellt ein `testdata_generator.sh` Skript oder Mock-JSON-Dateien.

### Prinzip 17: CI/CD Pipeline-Generierung (Deployment-Setup)
* **Implementierung:** Die KI ist ein "DevOps-Partner" (P17). Beim #Scaffolding (P0) generiert die KI eine `ci_cd_pipeline.yml` (z.B. für GitHub Actions), die #Linting, #Tests und #Deployment durchführt.

### Prinzip 18: "IntelliSense"-Architektur (Selbst-Dokumentation)
* **Implementierung:** Der von der KI (P0) generierte Code muss seine eigene #DokumentATION (P18) sein. Er *muss* #Strenge-Typsicherheit und #Standardisierte-Doc-Blocks (z.B. JSDoc) verwenden.

### Prinzip 19: Anforderungs-Management (Requirements Engineering)
* **Implementierung:** Das #Requirement (P19) ist das *Herzstück*. Die KI *fragt* nach der ersten Anforderung (z.B. `REQ-001`) und generiert ein `/requirements/REQ-001.md`. #Git-Commits (P0.5) *müssen* auf diese REQ-IDs verweisen.

### Prinzip 22: Das "Git-Operator" Protokoll (V3.11 Meta-Workflow)
* **Problem:** Wie entwickeln wir das #Framework (P0, P1-P21) selbst weiter, ohne die #Basis (den "funktionierenden Stand") zu #degradieren?
* **Lösung:** Wir nutzen #Git als "Single Source of Truth", wobei der #Architekt (der User) als "Git-Operator" und die KI (der Chat) als "Plausibilitäts-Prüfer" agiert.
* **Architektur-Workflow (V3.11):**
    1.  **Entwicklung (Sandbox-Chat):** Der Architekt aktiviert den #Architektur-Modus (V3.9 / `SITUATION 3` im Bootstrapper) in einem neuen Chat. Er entwickelt iterativ (z.B. P23).
    2.  **Kit-Generierung (Sandbox-Chat):** Der Architekt bittet die Sandbox-KI, ein **"V3.11 Git-Operator-Kit"** zu erstellen. Dieses Kit enthält die *vollständigen, neuen Zieldateien* und eine #Plausibilitäts-Begründung.
    3.  **Review (Architekten-Chat):** Der Architekt kopiert das "Kit" in den #Haupt-Architekten-Chat (diesen Chat).
    4.  **Plausibilität-Check (Architekten-Chat):** Die KI (hier) führt einen #KI-Diff-Check (Vergleich V-neu vs. V-alt) und einen #Logik-Check (P22) durch.
    5.  **Commit-Generierung (Architekten-Chat):** Bei Erfolg generiert die KI (hier) das **`git_operator_commit.sh`** Skript (V3.11).
    6.  **Ausführung (Lokales Terminal):** Der Architekt (Operator) führt das Skript *lokal* aus. Das Skript erzwingt einen `git diff` Check *vor* dem `git commit` und `git tag`, um die #Basis sicher zu aktualisieren.

---

## Phase 1: Die Kern-Architektur (Das "Worker-Pattern")

### Prinzip 5: Das "Worker-Interface-Pattern" (Dependency Injection)
* **Architektur:**
    1.  **Interfaces (P5):** Die "Verträge" (z.B. `ILogger`), definiert im #Core-Paket (P21).
    2.  **Services (P5):** Die "Werkzeuge" (z.B. `CSqlLogger`), die die Interfaces implementieren.
    3.  **Worker (P5):** Die "Denkmaschine" (z.B. `CInvoiceWorker`), die die Logik (P6-P11) enthält und *nur* die Interfaces kennt.
    4.  **Auslöser (P5):** Der "Zündschlüssel" (z.B. `main.ts`, Timer, P20-Event-Hörer). Er baut Services und Worker zusammen (#DependencyInjection).

---

## Phase 2: Das Fundament (Die "Service"-Implementierungen)

### 1. Prinzip: Zentralisierte Konfiguration (als `IConfiguration` Service)
### 2. Prinzip: Sicheres Secrets Management (im `IConfiguration` Service)
### 3. Prinzip: Physische Umgebungs-Trennung (im `IConfiguration` Service)
### 4. Prinzip: Persistentes, Strukturiertes Logging (als `ILogger` Service)
### 12. Prinzip: Aktive Alarmierung (als `IAlerting` Service)

---

## Phase 3: Die Architektur (Die "Worker"-Implementierung)

### 6. Prinzip: Idempotentes Design (Worker-Logik)
### 7. Prinzip: "Dry Run" / Test-Modus (Worker-Logik)

---

## Phase 4: Die Sicherheitsnetze (Die "Worker"-Schleife)

### 8. Prinzip: Sichere Stapelverarbeitung (Drip-Feed)
### 9. Prinzip: Interner Sicherheits-Timer (Timeout-Verhinderung)
### 10. Prinzip: Transaktionale Fehlerbehandlung (Item-Isolation)
### 11. Prinzip: Manueller Korrektur-Mechanismus (Re-Queue)

---

## Phase 5: Die System-Wartung (Betrieb & Optimierung)

(Implementiert als eigene V3.11-konforme Worker)

### 13. Prinzip: Proaktives Health-Monitoring (Der "Wächter")
### 14. Prinzip: Log-Rotation & Archivierung (Log-Hygiene)
### 15. Prinzip: Data "Garbage Collection" (Daten-Hygiene)

---

## Phase 6: Das Enterprise-Ökosystem (Skalierung & Governance)

### 20. Prinzip: Asynchrone Choreografie (Inter-Worker-Kommunikation)
* **Lösung:** Worker kommunizieren **asynchron** (P20) über ein zentrales #Event-Bus System (z.B. RabbitMQ, Kafka, SQS). Sie sind #entkoppelt.

### 21. Prinzip: Zentrales Framework-Core-Paket (Governance)
* **Lösung:** Alle #gemeinsamen Artefakte (Interfaces P5, Vorlagen P17) werden in ein versioniertes #Core-Paket (P21) extrahiert (z.B. `@company/automation-core`). Das #Scaffolding (P0) fügt dieses Paket als #Abhängigkeit (dependency) hinzu.
