# Azure CLI scripts

This folder contains the B2.E1, B2.E2, and B2.E3 Azure CLI-first workflows using `.azcli` command files.

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
- `06-validate-bicep-single-vm.azcli`
  - Validates Bicep template and parameters only (no resource deployment).
- `07-deploy-bicep-single-vm.azcli`
  - Deploys Bicep resources after validation succeeds.
- `08-inspect-bicep-single-vm.azcli`
  - Inspects deployed Bicep resources and VM details post-deployment.
- `09-what-if-bicep-single-vm.azcli`
  - Previews Bicep changes with what-if before deployment (no resource deployment).

- `11-cleanup-bicep-baseline-rg.azcli`
  - Deletes the Bicep baseline Resource Group for B2.E4 lifecycle cleanup before redeploy-from-scratch validation.
  - **Destructive**: review carefully before execution.


## Safety note

Commands that create, modify, or delete Azure resources must be reviewed before execution.

SSH access is restricted by passing `sshSourceAddressPrefix` with the operator public IP resolved at runtime in the `.azcli` workflow.


## B2.E3 runtime parameter handling

For B2.E3, `infra/parameters/dev.bicepparam` reads dynamic runtime values with `readEnvironmentVariable()` (for `ADMIN_PUBLIC_KEY` and `SSH_SOURCE_ADDRESS_PREFIX`).

The `.azcli` scripts (`06`, `07`, and `09`) set transient environment variables immediately before validate/what-if/deploy operations and remove them afterward.

`09-what-if-bicep-single-vm.azcli` is the required preview step to review infrastructure changes before deployment.

The public key is normalized with `.Trim()` before export so `adminPublicKey` remains stable across incremental runs.

This keeps real public SSH key content and operator public IP prefix values out of version control while preserving the same resource-group deployment scope.
