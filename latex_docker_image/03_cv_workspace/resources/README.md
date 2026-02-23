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
