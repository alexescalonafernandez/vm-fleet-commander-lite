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


## B2.E2 operational workflow (historical milestone)

Run the B2.E2 Bicep single-VM baseline in the following order:

1. Cleanup manual baseline Resource Group (destructive)
   - `scripts/azcli/05-cleanup-manual-baseline-rg.azcli`
2. Validate Bicep template (pre-deployment validation)
   - `scripts/azcli/06-validate-bicep-vm-fleet.azcli`
3. Deploy Bicep template (only after validation succeeds)
   - `scripts/azcli/08-deploy-bicep-vm-fleet.azcli`
4. Inspect deployed resources (post-deployment verification)
   - `scripts/azcli/09-inspect-vm-fleet.azcli`
5. Validate SSH connectivity
   - `scripts/azcli/03-test-ssh-connectivity.azcli`
6. Deallocate VM after SSH validation
   - `scripts/azcli/04-vm-power-operations.azcli`

## B2.E3 hardened operational workflow (historical milestone)

Run the hardened workflow in this order:

1. Validate
   - `scripts/azcli/06-validate-bicep-vm-fleet.azcli`
2. What-if (must be reviewed before deployment)
   - `scripts/azcli/07-what-if-bicep-vm-fleet.azcli`
3. Deploy (incremental)
   - `scripts/azcli/08-deploy-bicep-vm-fleet.azcli`
4. Inspect NSG/VM results
   - `scripts/azcli/09-inspect-vm-fleet.azcli`
5. Start VM if needed for SSH test
   - `scripts/azcli/04-vm-power-operations.azcli`
6. SSH validate
   - `scripts/azcli/03-test-ssh-connectivity.azcli`
7. Deallocate
   - `scripts/azcli/04-vm-power-operations.azcli`
8. Verify deallocated state
   - `scripts/azcli/04-vm-power-operations.azcli`


## B2.E4 lifecycle workflow (updated for current fleet scripts)

Run the B2.E4 lifecycle flow in this order:

1. Cleanup Bicep baseline Resource Group (destructive)
   - `scripts/azcli/11-cleanup-bicep-baseline-rg.azcli`
2. Verify Resource Group deletion
   - `scripts/azcli/11-cleanup-bicep-baseline-rg.azcli`
3. Validate Bicep template
   - `scripts/azcli/06-validate-bicep-vm-fleet.azcli`
4. What-if review (required safety gate)
   - `scripts/azcli/07-what-if-bicep-vm-fleet.azcli`
5. Deploy baseline from scratch
   - `scripts/azcli/08-deploy-bicep-vm-fleet.azcli`
6. Inspect deployed resources
   - `scripts/azcli/09-inspect-vm-fleet.azcli`
7. Start VM if needed
   - `scripts/azcli/04-vm-power-operations.azcli`
8. SSH validate
   - `scripts/azcli/03-test-ssh-connectivity.azcli`
9. Deallocate VM
   - `scripts/azcli/04-vm-power-operations.azcli`
10. Verify deallocated state
    - `scripts/azcli/04-vm-power-operations.azcli`

## Notes

- This milestone uses Azure CLI command files (`.azcli`) executed from VS Code/PowerShell 7.
- Bicep is intentionally not used in B2.E1; it is introduced in B2.E2.


## B2.E5 active VM fleet workflow

Use the active Bicep VM fleet workflow in this order:

1. Validate Bicep template
   - `scripts/azcli/06-validate-bicep-vm-fleet.azcli`
2. What-if review (required safety gate)
   - `scripts/azcli/07-what-if-bicep-vm-fleet.azcli`
3. Deploy VM fleet
   - `scripts/azcli/08-deploy-bicep-vm-fleet.azcli`
4. Inspect deployed fleet resources
   - `scripts/azcli/09-inspect-vm-fleet.azcli`
5. Perform VM fleet power operations
   - `scripts/azcli/10-vm-fleet-power-operations.azcli`
6. Cleanup baseline Resource Group when finished (destructive)
   - `scripts/azcli/11-cleanup-bicep-baseline-rg.azcli`

Historical B2.E2 and B2.E3 sections above capture milestone context and may reference workflow semantics from earlier tags, while script names here match the current repository state.
