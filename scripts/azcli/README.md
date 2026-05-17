# Azure CLI scripts

This folder contains the B2.E1 through B2.E6 Azure CLI-first workflows using `.azcli` command files.

## Current scripts

- `00-account-context.azcli`
  - Verifies Azure account and subscription context before any resource operations.
- `01-create-manual-vm-baseline.azcli`
  - Creates the B2.E1 manual Linux VM baseline resources.
- `02-inspect-manual-vm-baseline.azcli`
  - Inspects baseline resources and captures key VM details.
- `03-test-ssh-connectivity.azcli`
  - Opens an SSH session to the VM and documents the basic Linux commands to run manually.
- `04-vm-power-operations.azcli`
  - Handles VM power-state checks and deallocation verification.

- `05-cleanup-manual-baseline-rg.azcli`
  - Deletes the manual baseline Resource Group before Bicep validation/deployment.
  - **Destructive**: review carefully before execution.
- `06-validate-bicep-vm-fleet.azcli`
  - Validates Bicep template and parameters only (no resource deployment).
- `07-what-if-bicep-vm-fleet.azcli`
  - Previews Bicep changes with what-if before deployment (no resource deployment).
- `08-deploy-bicep-vm-fleet.azcli`
  - Deploys Bicep resources after validation succeeds.
- `09-inspect-vm-fleet.azcli`
  - Inspects deployed Bicep VM fleet resources and VM details post-deployment.
- `10-vm-fleet-power-operations.azcli`
  - Handles VM fleet power-state checks, start/deallocate operations, and post-action verification.
  - Ends the active B2.E5 runbook by deallocating all VMs after validation.
- `11-cleanup-bicep-baseline-rg.azcli`
  - Deletes the Bicep baseline Resource Group for B2.E4 lifecycle cleanup before redeploy-from-scratch validation.
  - **Destructive**: review carefully before execution.
- `12-fleet-observability.azcli`
  - Collects read-only fleet diagnostics after deployment/inspection evidence runs.
  - Inspects Resource Group resources, deployment outputs, VM power state, IPs/NICs/Public IPs, NSG SSH rule, Activity Log, and basic CPU metrics.
  - Does **not** start, stop, deallocate, delete, or create resources.


## Safety note

Commands that create, modify, or delete Azure resources must be reviewed before execution.

SSH access is restricted by passing `sshSourceAddressPrefix` with the operator public IP resolved at runtime in the `.azcli` workflow.


## B2.E3 runtime parameter handling

For B2.E3, `infra/parameters/dev.bicepparam` reads dynamic runtime values with `readEnvironmentVariable()` (for `ADMIN_PUBLIC_KEY` and `SSH_SOURCE_ADDRESS_PREFIX`).

The `.azcli` scripts (`06`, `07`, and `08`) set transient environment variables immediately before validate/what-if/deploy operations and remove them afterward.

`07-what-if-bicep-vm-fleet.azcli` is the required preview step to review infrastructure changes before deployment.

## Active B2.E5 Bicep VM fleet workflow order

1. `06-validate-bicep-vm-fleet.azcli`
2. `07-what-if-bicep-vm-fleet.azcli`
3. `08-deploy-bicep-vm-fleet.azcli`
4. `09-inspect-vm-fleet.azcli`
5. `10-vm-fleet-power-operations.azcli`
6. `11-cleanup-bicep-baseline-rg.azcli`

The public key is normalized with `.Trim()` before export so `adminPublicKey` remains stable across incremental runs.

This keeps real public SSH key content and operator public IP prefix values out of version control while preserving the same resource-group deployment scope.
