# Docker Compose Template — Dev Environment (Illustrative)

## Purpose

This template demonstrates how to run the final assembled development image produced by this layered build (Layer 04). It is intentionally minimal and focused on the dev environment only.

## Image to run

The template references the Layer 04 image with an overridable version:
```
services:
  dev:
    image: development-level04-project-stubs:${IMAGE_VERSION:-1.0.0}
```

You can change `IMAGE_VERSION` by exporting it in your shell or using a `.env` file next to `docker-compose.yml`:
```
IMAGE_VERSION=1.0.0
```

## Coding agent authentication

The current agent set (Layer 03) and their auth methods:

| Agent | Auth method | Env var needed? |
|-------|-------------|-----------------|
| Cline | VS Code / web auth flow | No |
| OpenCode | `opencode auth` / config file | No |
| Antigravity | Google OAuth (browser) | No |
| OpenAI Codex | `codex login` (interactive) | Optional: `OPENAI_API_KEY` |

The compose template passes `OPENAI_API_KEY` as an optional alternative to `codex login`. Other agents manage their own authentication internally.

## How to use

1. Build the images via the layered pipeline (01 → 02 → 03 → 04):
   ```
   cd scripts
   ./build_all.sh
   ```
2. Copy `.env.example` to `.env` (only if you need `OPENAI_API_KEY`):
   ```
   cp .env.example .env
   ```
3. Start the dev container:
   ```
   docker compose up -d
   ```
4. Connect via SSH:
   ```
   ssh -p 2222 developer@localhost
   ```
   Or enter interactively:
   ```
   ./03_enter_container.sh
   ```

## Ports

| Host | Container | Purpose |
|------|-----------|---------|
| 2222 | 22 | SSH access |

## Volumes (optional)

If you want your source code to persist on the host:
```
volumes:
  - ./workspace:/home/developer/dev
```

## Layered image structure

- **Layer 01**: Base software (sshd, base OS setup)
- **Layer 02**: Dev environments (Miniforge3, Java 21, build tools)
- **Layer 03**: Coding agents (RTK, Cline, OpenCode, Antigravity, Codex)
- **Layer 04**: Project stubs (final assembly image)

## Scripts

| Script | Purpose |
|--------|---------|
| `01_pull_images.sh` | Pulls the image (useful if built on another machine) |
| `02_start_dev.sh` | Starts the container via `docker compose up -d` |
| `03_enter_container.sh` | Enters the running container with an interactive shell |

## Security considerations

- Do not commit actual API keys to version control.
- Only commit `.env.example` (placeholders). Keep your real `.env` local and gitignored.
