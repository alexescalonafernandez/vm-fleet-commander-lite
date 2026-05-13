# B2.E3 - Bicep hardening results

## Purpose

B2.E3 hardens the Bicep single-VM baseline by restricting SSH access to the current operator IP while keeping the deployment workflow auditable through validate, what-if, and incremental deployment.

## What was hardened

| Area | Hardening action | Result |
|---|---|---|
| SSH source filtering | `sshSourceAddressPrefix` used instead of open source `*` | SSH narrowed to operator public IP CIDR |
| Runtime parameterization | `dev.bicepparam` uses `readEnvironmentVariable()` | Dynamic values injected at execution time |
| Scripted execution | `.azcli` scripts set transient environment variables before each operation | Validate/what-if/deploy run with consistent runtime inputs |
| SSH key handling | `adminPublicKey` read from local `.pub` and normalized with `.Trim()` | Prevented unintended key drift from whitespace/newline artifacts |

## Why SSH source restriction matters

Allowing SSH from `*` increases exposure to unsolicited scans and brute-force attempts. Restricting inbound TCP/22 to the operator CIDR (for example `94.227.129.94/32` during this run) reduces the attack surface while preserving operational access for validation.

## Operator IP resolution and CIDR conversion

The operator public IP is resolved at runtime from:

- `https://api.ipify.org`

Then converted to a single-host CIDR by appending `/32` before being passed to the deployment inputs.

## Runtime value flow

```text
.azcli scripts
  -> transient environment variables
    -> .bicepparam (readEnvironmentVariable())
      -> Bicep parameters
        -> NSG Allow-SSH sourceAddressPrefix
```

## What-if summary

`az deployment group what-if` was executed and reviewed before deployment.

Observed expected NSG delta:

- `sourceAddressPrefix: "*" => "94.227.129.94/32"`

## Deployment summary

- `az deployment group validate` succeeded.
- `az deployment group what-if` executed and reviewed.
- `az deployment group create` succeeded in incremental mode.
- NSG rule `Allow-SSH` confirmed with:
  - `SourceAddressPrefixes`: `94.227.129.94/32`
  - `DestinationPortRanges`: `22`
  - `Access`: `Allow`
  - `Protocol`: `Tcp`
  - `Direction`: `Inbound`

## SSH validation summary

- VM was started as needed for SSH validation.
- SSH connectivity succeeded with the restricted NSG rule.

## Cost-control result

- VM was deallocated after validation.
- Final VM power state: `VM deallocated`.

## Troubleshooting lessons learned

### 1) Placeholder value leak to Azure

Initial inline parameter override behavior was unreliable in this project context. The placeholder `REPLACE_WITH_OPERATOR_PUBLIC_IP_CIDR` propagated to Azure and triggered:

- `SecurityRuleInvalidAddressPrefix`

**Resolution:** Use `.bicepparam` + `readEnvironmentVariable()` for runtime substitution.

### 2) Public key whitespace/newline issue

A later deployment failed with:

- `PropertyChangeNotAllowed`
- `Changing property 'linuxConfiguration.ssh.publicKeys' is not allowed.`

Likely cause: trailing whitespace/newline from `Get-Content -Raw` when reading the `.pub` file.

**Resolution:** normalize before export:

- `(Get-Content $SSH_PUBLIC_KEY_PATH -Raw).Trim()`

After normalization, incremental deployment succeeded.

### 3) Idempotence and immutable VM properties

Incremental deployments remain reliable only when logically immutable VM properties are stable across runs. Input normalization and predictable runtime parameter flow are required to preserve idempotence.

## Outcome

B2.E3 improves the Bicep baseline by restricting SSH access while preserving an auditable deployment workflow.
