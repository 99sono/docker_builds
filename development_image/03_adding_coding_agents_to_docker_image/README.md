# Layer 03 — Adding Coding Agents to Docker Image

## Purpose
This layer builds on top of the Level 02 "dev environments" image to install AI coding agent CLIs and the RTK (Retool) plugin system.

This follows the project's layered approach:
- Level 01: Base software
- Level 02: Development environments (Java, Node.js, Python via Miniforge, build tools)
- Level 03: Coding agents (this layer)
- Level 04: Project stubs and final assembly

## Agents Included

| Agent | Install Method | RTK Plugin Command |
|-------|---------------|-------------------|
| RTK (shared) | Native binary (curl) | — |
| Cline | `npm install -g cline` | `rtk init --agent cline` |
| OpenCode | `npm install -g opencode-ai` | `rtk init -g --opencode` |
| Antigravity | Native binary (curl) | `rtk init --agent antigravity` |
| OpenAI Codex | `npm install -g @openai/codex` | `rtk init -g --codex` |

## Install Order

1. **RTK** — shared prerequisite, must be installed first
2. **Cline** — npm global + RTK plugin
3. **OpenCode** — npm global + RTK plugin
4. **Antigravity** — native binary + RTK plugin
5. **OpenAI Codex** — npm global + RTK plugin

Each agent's install script is self-contained: it installs the agent AND registers its RTK plugin in one atomic step.

## Build Instructions
From this directory:
```bash
./build.sh
```

This will produce an image tagged as:
```
development-level03-coding-agents:${IMAGE_VERSION}
```

## Verify Instructions
```bash
cd verify
./00_run_all_verifications.sh
```

## Runtime API Keys
For real usage, agents require authentication at runtime:
- Cline: Uses its own auth flow
- OpenCode: API key via config
- Antigravity: Google auth
- OpenAI Codex: `codex login` (exposes port 1455 for auth callback)

Verification scripts only check command presence and version, not API access.

## Files in this layer
- `Dockerfile`: Builds on Level 02 and installs all agents.
- `scripts/`: Self-contained installer scripts (one per agent + RTK).
- `build.sh`: Builds the Level 03 image.
- `verify/`: Verification scripts and orchestrator.
