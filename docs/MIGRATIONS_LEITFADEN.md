# Migrations-Leitfaden: Umgang mit "Brownfield"-Projekten (V3.11)

## Die Realität: Legacy Code
Beim Start (P0.4) wählen Sie zwischen zwei Migrations-Pfaden.

---

### Pfad 2: [Migration: Wrapper] (Das "Strangler Fig" Pattern)

Dies ist der **Sicherheits-Pfad**. Wir stabilisieren ein Altskript, ohne es zu verstehen.

* **Ziel:** Ein brüchiges #Altskript (z.B. ein altes Bash-Skript) schnell #robust (P10) und #transparent (P4, P12) zu machen.
* **Vorgehen (P0):**
    1.  Sie wählen **Option 2** im Bootstrapper.
    2.  Sie legen das Altskript in den `/import` Ordner (z.B. `/import/legacy_job.sh`).
    3.  Die KI (P0) generiert einen V3.11-konformen **"Harness-Worker"** (z.B. `CLegacyHarness.worker.ts`).
* **Architektur (P5):**
    * Dieser Harness-Worker ist ein normaler V3.11-Worker (P5).
    * Seine *einzige* Business-Logik (innerhalb des P10 `try...catch` Blocks) ist der Aufruf des Altskripts: `exec('bash ./import/legacy_job.sh')`.
* **Der Sofortige Nutzen:**
    * **P4 (Logging):** Der *Harness* loggt Start/Stopp.
    * **P10 (Isolation):** Wenn `legacy_job.sh` abstürzt, fängt der *Harness* den Fehler ab.
    * **P12 (Alerting):** Im `catch` Block ruft der *Harness* `this.alerting.triggerAlarm(...)` auf.
    * **P9 (Timeout):** Der *Harness* kann den `exec`-Befehl mit einem P9-Timeout kappen.

---

### Pfad 3: [Migration: Rewrite] (Das "Reverse Engineering" Pattern)

Dies ist der **Strategie-Pfad**. Wir lösen ein Altskript ab.

* **Ziel:** Ein Altskript #ablösen und als sauberen, wartbaren V3.11-Worker (P5, P21) neu zu implementieren.
* **Vorgehen (P0):**
    1.  Sie wählen **Option 3** im Bootstrapper.
    2.  Sie legen das Altskript in den `/import` Ordner (als Referenz).
    3.  Die KI (P0) startet **kein** Scaffolding, sondern beginnt mit dem #ReverseEngineering (P19): "Okay, lassen Sie uns `REQ-001` (P19) dafür definieren."
* **Architektur:**
    * Wir verwenden das Altskript als *Vorlage* für die #Anforderungs-Analyse (P19).
    * Der *Erstellungsprozess* folgt dann dem "Greenfield"-Tutorial (P0, P5).
