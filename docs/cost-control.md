# Cost Control

## Core principles

- VMs generate cost while running.
- **Stopped** and **deallocated** are not the same state.
- **Deallocated** is the expected end state after practice sessions.
- Public IPs, disks, and other resources may still generate costs depending on configuration.
- Cleanup is documented early to reduce accidental spending.

## B2.E1 cost-control notes

- The B2.E1 validation session ended with the VM deallocated.
- Expected final state: `VM deallocated`.
- Reminder: running VMs generate compute cost.
- Managed disks and Public IP resources may still generate cost depending on configuration.


## B2.E2 cost-control notes

- Bicep deployment creates a real VM and can generate compute cost.
- Final verified state for the B2.E2 run: `VM deallocated`.
- Resource Group deletion remains a separate reviewed cleanup step.
- Managed disks and Public IP may still have residual cost while the Resource Group exists.


## B2.E3 cost-control notes

- VM was deallocated after SSH validation.
- Final verified state: `VM deallocated`.
- SSH hardening improves exposure control but does not remove compute cost risk while a VM is running.
- Session-end deallocate remains mandatory.


## B2.E4 cost-control notes

- Resource Group deletion removes lab resources when no longer needed.
- Deletion is destructive and must be reviewed before execution.
- If redeployed, the VM must still be deallocated after validation.
- Final verified state: `VM deallocated`.



## B2.E5 cost-control notes

- Multi-VM deployment increases compute cost risk versus single-VM runs.
- All VMs must be deallocated after validation and operational checks.
- Final verified state: `VM deallocated`.
- Resource Group cleanup remains available through `11-cleanup-bicep-baseline-rg.azcli`.

## Session-end checklist

- Verify VM power state.
- Deallocate VM.
- Confirm no unexpected resources are running.
- Delete the resource group when the lab is no longer needed and deletion has been reviewed.
