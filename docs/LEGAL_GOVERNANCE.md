# Rechtliche Governance & Lizenzierung (V3.11)

## 1. Das Problem (Governance)
Ein Framework ohne #Lizenz (P-Legal) ist rechtlich unsicher. Standardmäßig gilt "Alle Rechte vorbehalten".

## 2. Das Framework Core-Paket (P21)
* **Empfehlung:** Dieses Paket (`@company/automation-core`) sollte eine *interne, proprietäre Lizenz* ("Copyright (c) [JAHR] [FIRMENNAME] - All Rights Reserved") erhalten.
* **Zweck:** Es stellt klar, dass diese Kern-IP dem Unternehmen gehört.

## 3. Der Generierte Worker-Code (P0)
* **Empfehlung:** Das #Scaffolding (P0) muss automatisch eine `LICENSE`-Datei in das Root-Verzeichnis jedes neuen Worker-Repositorys legen.
* **Inhalt:** Diese `LICENSE` sollte dieselbe interne, proprietäre Lizenz (siehe Punkt 2) enthalten.
