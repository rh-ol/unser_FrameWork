# Tutorial: Ihr Erster "Greenfield" Worker (V3.11)

**Ziel:** Wir bauen einen V3.11-konformen Worker, der eine "Hello World" Nachricht loggt, gesteuert durch den KI-Partner (P0).

---

### Schritt 1: Der "One Shot" Start (P0)

1.  **Starten Sie einen neuen Chat** mit dem KI-Partner.
2.  Kopieren Sie den **gesamten Inhalt** des `KI_BOOTSTRAP_PROMPT.md (V3.11)` und fügt ihn als erste Nachricht ein.

### Schritt 2: Das Profiling (P0.2 - P0.3)

1.  **KI-Antwort:** Die KI (im neuen Chat) wird `SITUATION 1` erkennen und Sie bitten, ein Profiling durchzuführen. Sie stellt Ihnen das `system_profiler.sh` Skript bereit.
2.  **Ihre Aktion:** Führen Sie dieses Skript auf Ihrem *lokalen Entwicklungs-Rechner* aus.
3.  **KI-Antwort:** Kopieren Sie die JSON-Ausgabe (den `{...}` Block) und fügen Sie sie als nächste Nachricht in den Chat ein.

### Schritt 3: Die Projekt-Auswahl (P0.4)

1.  **KI-Antwort:** Die KI erkennt das JSON (`SITUATION 2`), analysiert es und stellt Ihnen die "Drei-Optionen-Abfrage".
2.  **Ihre Aktion:** Antworten Sie mit:
    ```
    Ich wähle Pfad 1: [Neues Projekt] (Greenfield).

    * Worker Name: CLoggingWorker
    * Erste Geschäftsanforderung (P19): REQ-001: Der Worker soll beim Start eine einzelne Log-Nachricht 'Hello V3.11 World' mit dem Status INFO in das Log (P4) schreiben.
    ```

### Schritt 4: Das KI-Scaffolding (P0, P5, P17, P19)

1.  **KI-Antwort:** Die KI wird nun das gesamte Projekt-Scaffolding (alle `/src`, `/requirements`, `ci_cd_pipeline.yml` (P17) etc.) generieren, basierend auf Ihrem Profil (P0.3).

### Schritt 5: Der "Konversationelle Commit" (P0.5)

1.  **Ihre Aktion:** Sagen Sie zur KI:
    ```
    Das Scaffolding für REQ-001 ist abgeschlossen. Bitte bereite einen 'initial commit' (minor) vor.
    ```
2.  **KI-Antwort:** Die KI generiert nun das "Commit Kit" (P0.5) (Updates für `version.json`, `CHANGELOG.md` und das `commit_helper.sh` Skript).

**Glückwunsch!** Sie haben ein V3.11-konformes Projekt initiiert.
