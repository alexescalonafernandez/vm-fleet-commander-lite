# Cleanup

Destructive commands must be reviewed before execution.

## B2.E1 cleanup workflow

- Deallocate the VM after every practice session (mandatory).
- Verify the final power state is `VM deallocated`.
- Full Resource Group deletion is a destructive cleanup option and must be reviewed before execution.
- Review-required TODO for future milestone: add a controlled Resource Group deletion runbook (without adding delete commands yet).

## Cost review

- Confirm no VM remains running.
- Check for residual resource costs (for example disks and Public IPs).
