# B2.E1 Manual VM Baseline

## Purpose

B2.E1 establishes a minimal Linux VM baseline in Azure so the team can validate the core operational flow before introducing infrastructure-as-code.

## Why this milestone is CLI-first

This milestone intentionally uses an Azure CLI-first workflow so each operation is explicit, reproducible, and easy to audit in script form. The focus is operational confidence through command-driven steps rather than Portal-first interaction.

## Resource summary

| Item | Value |
| --- | --- |
| Resource Group | `rg-b2-vmfleet-dev-we-01` |
| VM name | `vm-b2-linux-01` |
| Region | `westeurope` |
| Image | `Ubuntu2204` |
| VM size | `Standard_B1s` |
| Admin user | `azureuser` |
| Authentication method | SSH key |
| Public IP observed | `20.105.250.219` |
| Final VM state | `VM deallocated` |

## Execution summary

- Account context checked.
- SSH key generated locally.
- Resource Group created.
- VM created with Azure CLI.
- VM inspected.
- SSH connection validated.
- Linux commands executed (`whoami`, `hostname`, `cat /etc/os-release`).
- VM deallocated.
- Deallocated state verified (`VM deallocated`).

## Notes

- Public IP can change in future sessions depending on allocation behavior.
- Private SSH key material must never be committed to the repository.
- Bicep is intentionally out of scope for B2.E1 and will be introduced in a later milestone.

## Outcome

B2.E1 successfully proves that the project can create, access, inspect, and safely deallocate a minimal Linux VM baseline.
