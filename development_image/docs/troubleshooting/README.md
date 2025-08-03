# Troubleshooting Guide

This guide helps resolve common issues encountered when using the development environment.

## Quick Diagnostic Commands

```bash
# Check container status
docker ps -a

# View container logs
docker logs test-dev-container

# SSH connection test
ssh developer@localhost -p 2222

# Check resource usage
docker stats
```

## Common Issues

### SSH Connection Problems
- [SSH Key Issues](ssh_connection_problems.md)
- [Permission Denied](ssh_connection_problems.md)
- [Connection Refused](ssh_connection_problems.md)

### Build Issues
- [Docker Build Failures](build_issues.md)
- [Permission Errors](build_issues.md)
- [Network Issues](build_issues.md)

### Runtime Issues
- [Container Won't Start](runtime_issues.md)
- [Port Conflicts](runtime_issues.md)
- [Memory Issues](runtime_issues.md)

## Getting Help

1. Check this troubleshooting guide
2. Review container logs: `docker logs test-dev-container`
3. Check verification scripts in each directory
4. Open an issue on GitHub with:
   - Container logs
   - Error messages
   - Steps to reproduce
