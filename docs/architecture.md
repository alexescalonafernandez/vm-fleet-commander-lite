# Architecture — VM Fleet Commander Lite

## Purpose of the architecture

Provide a minimal, repeatable Azure VM fleet topology that demonstrates AZ-104-relevant infrastructure and day-2 operations without introducing production-scale complexity.

## Current Lite architecture

The solution uses one shared network foundation and deploys one or more Linux VMs as a small fleet.

```text
Resource Group
├── VNet
│   └── Subnet
├── NSG (SSH source restricted)
└── VM Fleet (loop)
    ├── Public IP (per VM)
    ├── NIC (per VM)
    └── Linux VM (per VM)
```

## Shared resources

| Resource | Role in Lite design |
|---|---|
| Resource Group | Lifecycle boundary for deploy/cleanup and cost control. |
| VNet | Private network container for VM connectivity. |
| Subnet | Segment used by fleet NICs. |
| NSG | Inbound SSH rule restricted to approved source CIDR/range. |

## Per-VM resources

| Resource | Role in Lite design |
|---|---|
| Public IP | Direct SSH reachability for lab operations. |
| NIC | Interface binding VM to subnet and NSG-controlled traffic. |
| Linux VM | Compute workload used for provisioning and operations practice. |

## Bicep module structure

- `infra/main.bicep` — entry point and module orchestration.
- `infra/modules/network.bicep` — shared network components.
- `infra/modules/linux-vm-fleet.bicep` — VM loop and per-VM resources.
- `infra/parameters/dev.bicepparam` — environment defaults and deploy-time inputs.

## Runtime parameter strategy

- **`.bicepparam` as baseline:** stable defaults for lab environment.
- **`readEnvironmentVariable()` support:** runtime values can be injected from shell environment.
- **`.azcli` scripts:** operational wrappers pass deployment context consistently.
- **`.Trim()` on SSH public key input:** avoids whitespace/newline drift issues during deployment.

## Explicit non-inclusions (by design)

This Lite architecture does **not** include:

- VMSS
- Bastion
- Load Balancer
- Log Analytics Workspace
- Azure Monitor Agent
- CI/CD
- Production-grade fleet platform capabilities
