# VM Fleet Commander Lite

A compact, AZ-104-oriented Azure infrastructure and operations portfolio project that provisions and operates a small Linux VM fleet using Bicep and Azure CLI.

## Why this project exists

This repository demonstrates practical Azure administration skills in a controlled, cost-aware lab format for **Carril B — Azure Projects + AI Delivery Lab**. It is designed to show hands-on execution, validation evidence, and operational discipline rather than production platform breadth.

## Azure / AZ-104 skills demonstrated

- **Compute:** Linux VM provisioning, sizing choices, power-state operations.
- **Networking:** VNet/subnet foundations, NIC + Public IP, NSG rule hardening for SSH.
- **Security basics:** Restrict SSH ingress to an approved source range.
- **Infrastructure as Code:** Modular Bicep templates, parameters, what-if validation.
- **Operations with CLI:** Repeatable `.azcli` runbooks for deploy, inspect, operate, and cleanup.
- **Monitoring basics:** Read-only observability checks with Activity Log and platform metrics behavior.
- **Cost control:** Consistent stop/deallocate and cleanup workflow.

## Architecture overview

The current Lite architecture deploys shared network resources once per environment and creates one or more Linux VMs via a Bicep loop:

- **Shared resources:** Resource Group, VNet, Subnet, NSG (SSH restricted).
- **Per-VM resources:** Public IP, NIC, Linux VM.
- **IaC structure:** `infra/main.bicep` orchestrates `infra/modules/network.bicep` and `infra/modules/linux-vm-fleet.bicep`, parameterized by `infra/parameters/dev.bicepparam`.

For full details, see [docs/architecture.md](docs/architecture.md).

## Main workflow

1. Set account/subscription context.
2. Validate and preview infrastructure changes (`what-if`).
3. Deploy or redeploy via Bicep modules and parameters.
4. Inspect fleet state and verify SSH reachability.
5. Perform VM lifecycle operations (start/stop/deallocate).
6. Run read-only observability checks.
7. Cleanup resources when lab objectives are complete.

## Cost-control rule

**Every working session must end with VM deallocate or full resource cleanup.**

## Evidence produced

Evidence is captured as markdown runbooks and operational notes under `docs/`, including:

- Manual VM baseline and SSH validation.
- Bicep baseline, hardening, and what-if behavior.
- Cleanup and redeploy validation.
- Multi-VM loop deployment and fleet operations.
- Read-only diagnostics and observability behavior notes.

## Out-of-scope boundaries

This Lite portfolio intentionally excludes:

- VM Scale Sets (VMSS)
- Azure Bastion
- Load Balancer
- Log Analytics Workspace
- Azure Monitor Agent
- CI/CD pipelines and GitHub Actions
- Production-grade fleet platform concerns (HA/SLA architecture, full policy/compliance stack)

## Completed milestones and tags

- B2.E0 Project framing — `v0.1-project-framing`
- B2.E1 Manual VM baseline — `v0.2-manual-vm-baseline`
- B2.E2 Bicep single VM baseline — `v0.3-bicep-single-vm`
- B2.E3 Bicep hardening and operational polish — `v0.4-bicep-hardening`
- B2.E4 Lifecycle operations and redeploy validation — `v0.5-lifecycle-operations`
- B2.E5 Multi-VM loop baseline — `v0.6-multi-vm-loop-baseline`
- B2.E6 Fleet observability diagnostics — `v0.7-fleet-observability-diagnostics`

Current closeout milestone: **B2.E7 Final portfolio polish and project closeout**.
