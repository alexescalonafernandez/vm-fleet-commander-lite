# Cost Control

## Core principles

- VMs generate cost while running.
- **Stopped** and **deallocated** are not the same state.
- **Deallocated** is the expected end state after practice sessions.
- Public IPs, disks, and other resources may still generate costs depending on configuration.
- Cleanup is documented early to reduce accidental spending.

## Session-end checklist

- Verify VM power state.
- Deallocate VM.
- Confirm no unexpected resources are running.
- Delete the resource group when the lab is no longer needed.
