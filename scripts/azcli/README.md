# Azure CLI scripts

This folder contains the B2.E1 Azure CLI-first workflow using `.azcli` command files.

## Current scripts

- `00-account-context.azcli`
  - Verifies Azure account and subscription context before any resource operations.
- `01-create-manual-vm-baseline.azcli`
  - Creates the B2.E1 manual Linux VM baseline resources.
- `02-inspect-manual-vm-baseline.azcli`
  - Inspects baseline resources and captures key VM details.
- `03-test-ssh-connectivity.azcli`
  - Validates SSH connectivity to the VM and confirms basic Linux command execution.
- `04-vm-power-operations.azcli`
  - Handles VM power-state checks and deallocation verification.

## Safety note

Commands that create, modify, or delete Azure resources must be reviewed before execution.
