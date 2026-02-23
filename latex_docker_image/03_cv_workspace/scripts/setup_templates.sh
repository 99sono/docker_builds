#!/bin/bash
# setup_templates.sh - Part of Layer 03

USER_HOME="/home/developer"
TEMPLATE_SRC="/tmp/templates"

echo "[setup_templates] Setting up workspace directories..."

# Create templates and dev folders
mkdir -p "$USER_HOME/templates"
mkdir -p "$USER_HOME/dev"

# Move templates from temporary location to user home
if [ -d "$TEMPLATE_SRC" ]; then
    cp -r "$TEMPLATE_SRC"/* "$USER_HOME/templates/"
fi

# Create a master README in the developer home
cat > "$USER_HOME/README.md" << EOL
# LaTeX + Gemini CLI Workspace

Welcome! This environment is optimized for LaTeX document preparation.

## Folder Structure
- `~/templates/`: Contains starting points for your documents.
- `~/dev/`: This is where you should mount your host (WSL2) folders.

## How to start a new CV
1. Copy the template:
   `cp -r ~/templates/template_latex_cv_directory ~/dev/my_new_cv`
2. Enter your new directory:
   `cd ~/dev/my_new_cv`
3. Edit `main.tex` and run `./compile.sh`.

## Using Gemini CLI
You can use the `gemini` command to help write your CV. For example:
`gemini "Improve the grammar of this sentence: [your text]"`

Make sure your `GEMINI_API_KEY` is set in your environment.
EOL

# Ensure permissions are correct
chown -R developer:developer "$USER_HOME"
chmod +x "$USER_HOME/templates/template_latex_cv_directory/compile.sh"

echo "[setup_templates] Workspace setup complete."
