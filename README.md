# COMP 331: AI-Assisted Software Engineering

This repository contains a Quarto site built from Jupyter notebooks. It hosts COMP 331: AI-Assisted Software Engineering, a 12-week undergraduate course. The site uses reveal.js for slide-style presentations generated from the notebooks.

## Quick overview

- Project root contains the Quarto config file (`_quarto.yml`) and a top-level `index.qmd`.
- Notebooks for the course are in `lectures/` (one notebook per week).
- Assignments are in `assignments/` and docs in `docs/`.
- Site output (generated) lives in `_site/` and is ignored by the repo via `.gitignore`.

## Getting started (fast path)

These steps assume you're on macOS (or Linux) and have a POSIX shell (zsh/bash).

1. Install system prerequisites

- Install Python 3.12+ (pyenv or conda recommended). See https://www.python.org/.
- Install Quarto: https://quarto.org/docs/get-started/

2. (Optional, recommended) Install `uv` for quick environment management

`uv` is a small tool we recommend for creating and using isolated virtual environments quickly.

```bash
curl -Ls https://astral.sh/uv/install.sh | sh
```

3. Create and activate a project virtual environment

```bash
uv venv .venv    # creates .venv in the repo root
source .venv/bin/activate
```

4. Install Python dependencies

There is no central `requirements.txt` in this repository; the minimal packages you need to work on the content are Jupyter and Quarto-related Python packages. Install at least Jupyter:

```bash
uv pip install jupyter
# add other packages your notebooks need, e.g. numpy, pandas, scikit-learn
```

5. Preview or render the site

- Preview (live, auto-reload):

```bash
quarto preview
```

- Full render (produce `_site/`):

```bash
quarto render
```

## Working with notebooks

- Open notebooks in Jupyter or JupyterLab while the virtual environment is activated:

```bash
jupyter lab
```

- Edit notebooks in `lectures/` or `assignments/`. After editing, use `quarto render` to rebuild the site.

## Publishing

This site is published with GitHub Actions to GitHub Pages.

- Pushes to `main` run `.github/workflows/publish.yml`.
- The workflow installs Quarto and Python dependencies, runs `quarto render`, and publishes `_site/` to the `gh-pages` branch.
- GitHub Pages should be configured to deploy from the `gh-pages` branch.
- Published site URL: https://t-morgan.github.io/ai-assisted-software-engineering/

The local `origin` remote should point to:

```bash
git@github.com:t-morgan/ai-assisted-software-engineering.git
```

If your local checkout still uses the old misspelled repository URL, update it before pushing.

## Project structure

- `lectures/` — Jupyter notebooks used to generate weekly lecture slides.
- `assignments/` — assignment notebooks and metadata.
- `docs/` — supporting docs for the course.
- `_site/` — generated site output (ignored by git).
- `site_libs/` — vendored JS/CSS used by the site (checked in to avoid external fetches).

## Git and contributing

- This repo uses a basic `main` branch. Please create feature branches for changes:

```bash
git checkout -b feature/update-lecture-03
```

- Commit messages should be short and descriptive. Example:

```
git commit -m "fix(lecture03): correct example for API design"
```

## Helpful tips

- If notebooks have heavy outputs or large attachments you want to omit, clear cell outputs before committing (Jupyter: Kernel → Restart & Clear Output).
- If you prefer Conda/venv over `uv`, that's fine — the project ignores typical virtualenv folders via `.gitignore`.

## Links

- Quarto docs (presentations): https://quarto.org/docs/presentations/revealjs/
- `uv` (recommended): https://astral.sh

## Dependencies

This repository includes a minimal `requirements.txt` listing common packages used when editing or running the notebooks locally. The project also contains `pyproject.toml` (for packaging metadata); currently `pyproject.toml` does not declare runtime dependencies.

To install the packages from `requirements.txt` into your active virtual environment:

```bash
uv pip install -r requirements.txt
# or, without uv: python -m pip install -r requirements.txt
```

If you'd prefer to manage dependencies via `pyproject.toml`/Poetry or another tool, that's also fine—`requirements.txt` is provided for convenience and quick setup.
