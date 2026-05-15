# Lifecycle Operations (B2.E4)

## Purpose

B2.E4 validates full lifecycle operations for the hardened Bicep baseline: cleanup, redeploy, verification, and safe shutdown.

## Why this matters before multi-VM fleet support

As the repository evolved to a VM fleet baseline, the lifecycle flow remains the same and must still prove resources can be safely:

- Removed without leftovers.
- Recreated from scratch with the same workflow.
- Validated operationally (inspection + SSH).
- Returned to a cost-safe end state.

This reduces drift risk and confirms reproducibility for upcoming fleet-level operations.

## Lifecycle workflow summary

| Step | Action | Script |
|---|---|---|
| 1 | Cleanup baseline Resource Group | `scripts/azcli/11-cleanup-bicep-baseline-rg.azcli` |
| 2 | Verify deletion | `scripts/azcli/11-cleanup-bicep-baseline-rg.azcli` |
| 3 | Validate template | `scripts/azcli/06-validate-bicep-vm-fleet.azcli` |
| 4 | Review what-if | `scripts/azcli/07-what-if-bicep-vm-fleet.azcli` |
| 5 | Deploy from scratch | `scripts/azcli/08-deploy-bicep-vm-fleet.azcli` |
| 6 | Inspect deployment | `scripts/azcli/09-inspect-vm-fleet.azcli` |
| 7 | SSH / power operations | `scripts/azcli/10-vm-fleet-power-operations.azcli` |
| 8 | Deallocate VM fleet | `scripts/azcli/10-vm-fleet-power-operations.azcli` |

## Cleanup script summary

`11-cleanup-bicep-baseline-rg.azcli` covers three controls:

- **Target Resource Group:** `rg-b2-vmfleet-dev-we-01`.
- **Review before delete:** explicit destructive step review before execution.
- **Verification after delete:** confirms the Resource Group no longer exists.

## Redeploy-from-scratch summary

After deletion verification, the hardened baseline was recreated using the existing B2.E3 workflow:

1. Validate (`06`)
2. What-if (`07`)
3. Deploy (`08`)
4. Inspect (`09`)
5. SSH / power operations (`10`)
6. Deallocate (`10`)

## Operational evidence

- Baseline Resource Group deletion completed successfully.
- Deletion was verified before redeployment.
- Validation succeeded.
- What-if was executed and reviewed.
- Deployment succeeded.
- Inspection succeeded.
- SSH connectivity succeeded.
- VM was deallocated after validation.
- Final VM state: `VM deallocated`.

## Cost-control outcome

B2.E4 confirms two cost controls are working as expected:

- Full Resource Group deletion when the lab is not needed.
- Mandatory deallocation after validation when resources are redeployed.

## Lessons learned

- Cleanup is part of operations, not just housekeeping.
- Redeploy from scratch validates reproducibility.
- What-if remains a required safety gate.
- Final VM state must always be verified.

## Outcome

B2.E4 proves the hardened baseline can be safely destroyed, recreated, inspected, used, and deallocated.
