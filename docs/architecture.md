# Architecture (Lite)

## Target architecture

The Lite version targets a minimal Azure VM topology focused on AZ-104 learning outcomes.
The initial implementation starts with **one Linux VM**.

## Expected resources (future milestones)

- Resource Group
- VNet
- Subnet
- NSG
- Public IP
- NIC
- Linux VM
- OS disk

## Text diagram

```text
Resource Group
└── VNet
    └── Subnet
        └── NIC ── Linux VM
             ├── NSG
             ├── Public IP
             └── OS Disk
```

## Milestone note

Actual Bicep implementation starts in a later milestone (not in B2.E0).
