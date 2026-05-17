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

B2.E2 (Bicep single-VM baseline) is preserved in Git history and tag `v0.3-bicep-single-vm`.

The current repository has evolved to the VM fleet workflow.

For current execution, use the **B2.E5 active VM fleet workflow** section in this document.

## B2.E3 hardened operational workflow (historical milestone)

B2.E3 (single-VM hardening workflow) is preserved in Git history and tag `v0.4-bicep-hardening`.

The current repository has evolved to the VM fleet workflow.

For current execution, use the **B2.E5 active VM fleet workflow** section in this document.

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

Historical B2.E2 and B2.E3 sections above are preserved for milestone context and point to the relevant tags. For current execution in this repository, follow the B2.E5 workflow above.

For baseline results and evidence from this milestone, see `docs/multi-vm-loop-baseline.md`.

## B2.E6 operational diagnostics

Use B2.E6 diagnostics after deployment and inspection when operational evidence is needed.

- Primary script: `scripts/azcli/12-fleet-observability.azcli`
- Runbook: `docs/fleet-diagnostics.md`
- Scope: **read-only diagnostics** (no resource create/update/delete actions)

Recommended sequence:

1. Deploy and inspect the fleet using the active B2.E5 workflow.
2. Run `scripts/azcli/12-fleet-observability.azcli` to collect diagnostics.
3. Use `docs/fleet-diagnostics.md` to triage findings by layer.
4. If deeper checks require running VMs, use `scripts/azcli/10-vm-fleet-power-operations.azcli`, then deallocate all VMs again at session end.
