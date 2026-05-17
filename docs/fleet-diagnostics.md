# Fleet Diagnostics Runbook

## Purpose
This runbook provides a practical, layered troubleshooting path for common VM fleet operational issues, using Azure control-plane evidence first before making guest OS assumptions.

## Diagnostic principle
- Start with Azure-side evidence before assuming guest OS or SSH daemon issues.
- Verify resource existence, power state, network exposure, NSG source rules, public IP assignment, and deployment state first.
- Treat troubleshooting as part of the learning process: collect evidence, narrow scope, then act.

## Core diagnostic workflow
Use this sequence consistently:
1. Confirm subscription context.
2. Confirm Resource Group exists.
3. List resources.
4. Check deployment state and outputs.
5. Check VM power/provisioning state.
6. Check Public IP and NIC state.
7. Check NSG SSH rule.
8. Compare operator public IP with NSG source prefix.
9. Check Activity Log.
10. Check metrics if useful.
11. Only then consider guest OS / SSH service assumptions.

## Scenario runbooks

### SSH timeout
**Symptoms**
- SSH command hangs, times out, or cannot connect.

**Likely layers (in order)**
- VM is deallocated.
- Public IP is missing or changed.
- NSG source IP does not match current operator IP.
- Wrong SSH private key or wrong key path.
- Guest OS SSH service issue (only after Azure checks above).

**Checks to run**
- `scripts/azcli/09-inspect-vm-fleet.azcli`
- `scripts/azcli/12-fleet-observability.azcli`
- `scripts/azcli/10-vm-fleet-power-operations.azcli` (if start/stop action is needed)

**Do not assume too early**
- Do not start by blaming guest OS configuration before validating Azure-side reachability and policy.

### VM deallocated
**What it means**
- Deallocated VMs are stopped at the platform level and do not serve inbound SSH.

**Why SSH fails**
- No running guest workload means no active SSH endpoint.

**Action**
- Start the fleet using `scripts/azcli/10-vm-fleet-power-operations.azcli`.
- Re-test connectivity only after VMs report running state.

**Cost reminder**
- After validation, deallocate VMs again to control lab cost.

### NSG source IP mismatch
- `sshSourceAddressPrefix` limits SSH ingress to the operator public IP with `/32` precision.
- If your operator network/egress changes, SSH can fail even when VM and NIC are healthy.
- If update is needed, re-run the validate/what-if/deploy workflow so NSG source prefix reflects current operator IP.
- The script uses `https://api.ipify.org` to resolve the operator public egress IP.

### Public IP missing or unexpected
- Check `az vm list-ip-addresses` output.
- Check Public IP resources in the Resource Group.
- Check deployment outputs for expected IP references.
- Do not assume VM failure when public IP references are missing or changed; confirm control-plane wiring first.

### Deployment failed
- Check deployment result/status first.
- If needed, inspect deployment operations for failing resource details.
- Review Bicep diagnostics in VS Code.
- Keep prior lesson in mind: Bicep loop syntax issues and immutable VM properties can break deployments.

### Quota or VM size issue
**Symptoms**
- Deployment fails with allocation/size-related errors.

**Likely cause**
- Regional quota or VM SKU availability issue.

**Action**
- Read Azure error details before changing architecture decisions.
- Keep VM size small for lab scenarios (for example, `Standard_B1s`).

### Empty Activity Log
- Empty output is acceptable.
- It usually means no matching recent events were returned for the selected Resource Group/time window.
- Activity Log may show both user-triggered operations and platform-generated events (for example, Azure Advisor).

### Sparse CPU metrics
- CPU metric output may include timestamps with no values.
- This can occur when VMs are deallocated, recently inactive, or missing recent samples.
- Do not treat sparse metrics as failure by default.

## Evidence checklist
Capture the following for every troubleshooting session:
- Date/time
- Active subscription
- Resource Group
- VM names
- Power states
- Public IPs
- NSG SSH source prefix
- Operator public IP
- Activity Log finding
- Metric finding
- Final action
- Final VM state

## Cost-control reminder
- If diagnostics require starting VMs, deallocate all VMs after troubleshooting.
- Final expected state after lab work: `VM deallocated`.
