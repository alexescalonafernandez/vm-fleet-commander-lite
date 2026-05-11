# Operations

## B2.E1 operational workflow

Run the B2.E1 manual VM baseline in the following order:

1. Account context
   - `scripts/azcli/00-account-context.azcli`
2. Create VM baseline
   - `scripts/azcli/01-create-manual-vm-baseline.azcli`
3. Inspect resources
   - `scripts/azcli/02-inspect-manual-vm-baseline.azcli`
4. Test SSH
   - `scripts/azcli/03-test-ssh-connectivity.azcli`
5. Check power state and perform power operations
   - `scripts/azcli/04-vm-power-operations.azcli`
6. Deallocate VM
   - `scripts/azcli/04-vm-power-operations.azcli`
7. Verify deallocated state
   - `scripts/azcli/04-vm-power-operations.azcli`

## Notes

- This milestone uses Azure CLI command files (`.azcli`) executed from VS Code/PowerShell 7.
- Bicep is not used in B2.E1.
