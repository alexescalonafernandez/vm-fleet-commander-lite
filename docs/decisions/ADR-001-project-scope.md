# ADR-001 - Project scope and Lite implementation

- **Status:** Accepted

## Context

The original VM Fleet Commander idea includes Bicep modules, loops, multiple VMs, networking, parameter files, validation, deployment, maintenance, documentation, and cleanup.

## Decision

Implement a Lite version first, focused on one Linux VM, basic networking, SSH, Azure CLI operations, Bicep, documentation, troubleshooting, and cost control.

## Consequences

- The project remains small and auditable.
- It supports AZ-104 practical learning.
- Advanced fleet features are deferred.
- The repository name includes Lite, but Azure resource names use `b2-vmfleet` (without lite) to allow future evolution.
