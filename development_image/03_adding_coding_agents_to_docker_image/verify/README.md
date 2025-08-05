# Verify — Layer 03 (Coding Agents)

Purpose
This folder contains scripts to verify that the Level 03 image (Coding Agents) builds correctly and that the Gemini CLI is installed and available.

Pre-requisites
- The Level 02 image must exist locally with the same IMAGE_VERSION used to build this layer.
- Docker is installed and running.
- You have built the Level 03 image (see below).

Image naming conventions
We follow the same convention as other layers, sourcing from `development_image/00_common_env.sh`:
- Base (Level 02) image: `${IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:${IMAGE_VERSION}`
- Target (Level 03) image: `${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}`

Build the Layer 03 image
From `development_image/03_adding_coding_agents_to_docker_image`:
```
./build.sh
# or with explicit version:
IMAGE_VERSION=1.0.0 ./build.sh
```

Verification steps

1) Start a test container
Runs a detached container based on the Level 03 image, with a deterministic container name for subsequent steps.
```
cd verify
./01_A_run_built_container_entrypoint_script.sh
```

2) (Optional) Enter the container
For manual exploration and checks inside the running container:
```
./02_enter_test_dev_container.sh
# Within the container you can try:
#   gemini --version
#   which gemini
#   echo $PATH
```

3) Verify Gemini CLI presence
Checks that the `gemini` command is available and prints its version.
```
./03_verify_gemini_cli.sh
```

Expected output
- The verify script should print the path to the `gemini` binary and a non-empty version string.
- Example:
  ```
  [verify-03/gemini] gemini path: /usr/local/bin/gemini
  [verify-03/gemini] gemini version: gemini-cli/x.y.z ...
  [verify-03/gemini] Verification PASSED.
  ```

Notes about API keys
- GEMINI_API_KEY is required by the Gemini CLI for actual API calls. The above verification does NOT require an API key; it only checks that the CLI binary is installed and on PATH.
- OPENROUTER_API_KEY is reserved for future agents (e.g., Aider/Qwen via OpenRouter). It is not used by this layer’s verification.

Cleanup
To stop and remove the test container:
```
docker rm -f dev-test-level03
