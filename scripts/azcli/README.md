# Azure CLI scripts

This folder contains the B2.E1 and B2.E2 Azure CLI-first workflows using `.azcli` command files.

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


## Safety note

Commands that create, modify, or delete Azure resources must be reviewed before execution.

SSH access is restricted by passing `sshSourceAddressPrefix` with the operator public IP resolved at runtime in the `.azcli` workflow.
