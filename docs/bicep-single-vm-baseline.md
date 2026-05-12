# B2.E2 — Bicep single VM baseline

## Purpose

B2.E2 validates that the VM baseline can be reproduced using Bicep, replacing one-off manual creation with a repeatable infrastructure definition.

## Why move from manual baseline to Bicep

- Improves repeatability and consistency across executions.
- Reduces manual drift between practice sessions.
- Makes validation/deployment steps explicit and reviewable.
- Creates a clear path from hands-on baseline work (B2.E1) to infrastructure-as-code operations.

## Why minimal modularization from the start

A minimal modular layout was used immediately to keep the baseline easy to understand while establishing separation of concerns:

- network resources in one module
- VM resources in one module
- shared orchestration in `main.bicep`

This keeps the first Bicep milestone simple without locking the project into a single-file structure.

## Bicep structure

| File | Role |
|---|---|
| `infra/main.bicep` | Orchestrates module composition and parameters. |
| `infra/modules/network.bicep` | Defines VNet, subnet, NSG, and related networking resources. |
| `infra/modules/linux-vm.bicep` | Defines the Linux VM and attaches the NIC produced by the network module. |
| `infra/parameters/dev.bicepparam` | Development parameter baseline with placeholder SSH key value. |

## Resource summary

- Resource Group: `rg-b2-vmfleet-dev-we-01`
- Region: `westeurope`
- VM: `vm-b2-linux-01`
- VNet: `vnet-b2-vmfleet-dev-we-01`
- Subnet: `snet-vms-dev-we-01`
- NSG: `nsg-vms-dev-we-01`
- Public IP: `pip-vm-b2-linux-01`
- NIC: `nic-vm-b2-linux-01`
- VM size: `Standard_B1s`
- Image: `Ubuntu 22.04 LTS Gen2`

## Execution summary

1. Cleanup manual baseline resource group.
2. Validate Bicep template (`provisioningState: Succeeded`).
3. Deploy Bicep template (`provisioningState: Succeeded`).
4. Inspect deployed resources.
5. Validate SSH connectivity.
6. Deallocate VM.
7. Verify final VM state is deallocated.

## Parameter strategy (SSH key)

- `adminPublicKey` remains a placeholder in committed `infra/parameters/dev.bicepparam`.
- The real SSH public key is read from a local `.pub` file by the Azure CLI workflow.
- The key value is passed as an inline parameter override during validation/deployment.
- No private key material is committed.

## Outcome

B2.E2 proves that the project can reproduce the VM baseline with modular Bicep and operate it safely.
