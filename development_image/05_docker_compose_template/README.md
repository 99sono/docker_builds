# Docker Compose Template — Dev Environment (Illustrative)

Purpose
This template demonstrates how one might run the final assembled development image produced by this layered build (typically from Layer 04). It is intentionally minimal and focused on the dev environment only, removing unrelated services (e.g., Redis, Postgres).

What this template is (and is not)
- It is a starting point for consuming the final image outside of this repository’s build workflow.
- It is not a full-stack application compose file.
- It does not start additional services by default; add those only if your project needs them.

Image to run
Replace the image reference with the tag you build in your environment. By default the template references the Layer 04 image name and an overridable version:
```
services:
  dev:
    image: development-level04-project-stubs:${IMAGE_VERSION:-1.0.0}
```
You can change IMAGE_VERSION by exporting it in your shell or using an .env file next to docker-compose.yml:
```
IMAGE_VERSION=1.0.0
```

Runtime environment variables for coding agents
Some coding agents require API keys at runtime. This template includes common variables as placeholders:
```
environment:
  OPENROUTER_API_KEY: ${OPENROUTER_API_KEY:-}
  GEMINI_API_KEY: ${GEMINI_API_KEY:-}
```
- GEMINI_API_KEY: Required by the Google Gemini CLI to make API calls.
- OPENROUTER_API_KEY: Used by agents configured to route via OpenRouter (future integrations like Aider/Qwen). The Level 03 verification does not require these keys.

How to use this template
1) Ensure you have built the images via the layered pipeline (01 → 02 → 03 → 04).
2) Update the image field in docker-compose.yml to match your built image/tag.
3) Optionally set API keys in your shell or an .env file:
   ```
   export GEMINI_API_KEY=your_gemini_api_key
   export OPENROUTER_API_KEY=your_openrouter_api_key
   ```
4) Start the dev container:
   ```
   docker compose up -d
   ```
5) Enter the container (if needed):
   ```
   docker exec -it dev-environment bash
   ```

Ports
The template maps SSH port 22 in the container to 2222 on the host:
```
ports:
  - "2222:22"
```
This matches the stack’s inherited entrypoint behavior (sshd from the base layers). Adjust as needed.

Volumes (optional)
If you want your source code to live on the host and be available in the container, uncomment and modify:
```
# volumes:
#   - ./workspace:/home/developer/workspace
```

Notes on layered structure
- Layer 01: Base software (sshd, base OS setup)
- Layer 02: Dev environments (Java, Node.js + npm, Miniforge/Python, build tools)
- Layer 03: Coding agents (Gemini CLI integrated first; more agents added progressively)
- Layer 04: Project stubs (final assembly image; recommended for use in this template)

Troubleshooting
- If the container starts but you cannot exec:
  - Check `docker ps` for container status.
  - Review logs: `docker logs dev-environment`
- If coding agents fail to run due to missing keys:
  - Confirm the environment variables are correctly passed (docker compose config).
  - Verify the agent CLI’s own documentation for additional setup needs.

Security considerations
- Do not commit actual API keys to version control.
- Prefer `.env` files that are gitignored or pass variables via CI/CD secrets/runner configuration.
