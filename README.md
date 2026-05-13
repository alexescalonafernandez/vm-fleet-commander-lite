# VM Fleet Commander Lite

A practical Azure VM operations and Bicep lab for AZ-104 skills.

## Context

This project belongs to **Carril B — Azure Projects + AI Delivery Lab**.

## Goal

Build a small, reproducible Azure VM environment for learning:
- VM provisioning
- Day-2 operations
- Networking basics
- SSH access
- Troubleshooting
- Cost control

## Current milestone

- **B2.E0 - Project framing (completed)**
- **B2.E1 - Manual VM baseline (completed)**
- **B2.E2 - Bicep single VM baseline (completed)**
- **B2.E3 - Bicep hardening and operational polish (completed)**

## Lite scope (in)

- Azure Linux VM
- Resource Group
- VNet/Subnet
- NSG
- SSH
- Azure CLI
- Bicep
- `.azcli` workflow in VS Code
- Start/stop/deallocate operations
- Cleanup documentation

## Out of scope for now

- VM Scale Sets
- Bastion
- Load Balancer
- Advanced monitoring
- CI/CD deployment automation
- Production-grade fleet management

## Initial Azure naming baseline

- Workload: `b2-vmfleet`
- Environment: `dev`
- Region: `West Europe`
- Example Resource Group: `rg-b2-vmfleet-dev-we-01`

## Cost-control rule

Every VM session must end with **deallocate** or **cleanup**.

## Planned milestone tags

- `v0.1-project-framing`
- `v0.2-manual-vm-baseline`
- `v0.3-bicep-single-vm`
- `v0.4-bicep-modules`
- `v0.5-mini-fleet`
- `v0.6-operations-runbook`
- `v1.0-final-lite`
