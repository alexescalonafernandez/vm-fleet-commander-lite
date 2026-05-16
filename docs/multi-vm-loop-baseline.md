# B2.E5 Multi-VM Bicep Loop Baseline

## Purpose

B2.E5 documents the transition from a single-VM Bicep baseline to a loop-driven VM fleet baseline.

## Why this is the first real fleet milestone

This is the first milestone that provisions and operates multiple VMs from one Bicep deployment model using parameterized loops.

## Lite fleet scope

| Item | Scope |
|---|---|
| VM count | 2 |
| VM Scale Sets | Not included |
| Load Balancer | Not included |
| Bastion | Not included |
| CI/CD | Not included |

## Architecture summary

- Shared networking remains in `infra/modules/network.bicep`.
- Fleet compute is managed in `infra/modules/linux-vm-fleet.bicep`.
- Per-VM resources are created through loops:
  - Public IP
  - NIC
  - Linux VM

## Bicep loop design

- `vmCount = 2` is defined in `infra/parameters/dev.bicepparam`.
- Naming pattern is index-based and deterministic:
  - VMs: `vm-b2-linux-01`, `vm-b2-linux-02`
  - NICs: `nic-vm-b2-linux-01`, `nic-vm-b2-linux-02`
  - Public IPs: `pip-vm-b2-linux-01`, `pip-vm-b2-linux-02`
- `infra/modules/linux-vm.bicep` was replaced by `infra/modules/linux-vm-fleet.bicep` to reflect module responsibility.

## Runtime parameter strategy

- Runtime values continue to use `.bicepparam` + `readEnvironmentVariable()`.
- `.azcli` workflow scripts set and clear required environment variables at runtime.
- SSH public key is normalized with `.Trim()` before export.

## Validation evidence

- VS Code Bicep diagnostics detected initial loop syntax issues.
- Loop syntax was corrected.
- `az deployment group validate` then succeeded.

## What-if evidence

- `az deployment group what-if` was executed and reviewed.
- What-if showed creation of second-VM resources:
  - `vm-b2-linux-02`
  - `nic-vm-b2-linux-02`
  - `pip-vm-b2-linux-02`

## Deployment evidence

- `az deployment group create` succeeded in incremental mode.

## Operational evidence

- Fleet inspection succeeded.
- Fleet power operations succeeded.
- Final verified VM fleet state: `VM deallocated`.

## Active B2.E5 script workflow

1. `06-validate-bicep-vm-fleet.azcli`
2. `07-what-if-bicep-vm-fleet.azcli`
3. `08-deploy-bicep-vm-fleet.azcli`
4. `09-inspect-vm-fleet.azcli`
5. `10-vm-fleet-power-operations.azcli`
6. `11-cleanup-bicep-baseline-rg.azcli`

Legacy single-VM inspection flow is no longer part of the active B2.E5 workflow. Historical single-VM evidence remains in earlier tags.

## Lessons learned

- Bicep loop syntax precision matters.
- Module names should reflect actual responsibility.
- Script numbering should match real operational order.
- Fleet operation increases cost-control importance.

## Outcome

B2.E5 proves this project can deploy and operate a small VM fleet using Bicep loops.
