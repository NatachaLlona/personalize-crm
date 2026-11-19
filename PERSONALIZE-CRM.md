# Personalize CRM

From this directory, run `.\start.ps1` in PowerShell with Docker Desktop running.
The script reads `public_host` and `public_port` from `config.json` and prints the login URL.
Keep `project_name` as `personalize-crm` to reuse the existing Docker volumes.

The local instance uses ERPNext v16 on Frappe. The Compose file is intended for local development.
