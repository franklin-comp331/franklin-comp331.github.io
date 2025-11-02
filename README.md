# AI-Assisted Software Engineering Lectures

This Quarto project contains Jupyter notebook-based reveal.js presentations for a 12-week undergraduate course on AI-Assisted Software Engineering.

## Structure
- `quarto.yml`: Project configuration.
- `lectures/`: Jupyter notebooks for each lecture (one per week).


## Running Locally

Follow these steps to run the project locally:

### 1. Install Prerequisites

- **Python 3.12+** (recommended to use [pyenv](https://github.com/pyenv/pyenv) or [Anaconda](https://www.anaconda.com/))
- **Quarto**: [Install Quarto](https://quarto.org/docs/get-started/)
- **Jupyter**: Install via pip or conda (see below)


### 2. Set Up Python Environment with `uv`

This project recommends using [`uv`](https://github.com/astral-sh/uv) for fast Python environment management and package installation.

Install `uv` (if not already installed):

```bash
curl -Ls https://astral.sh/uv/install.sh | sh
```

Create and activate a virtual environment:

```bash
uv venv .venv
source .venv/bin/activate
```

Install Jupyter and any other dependencies:

```bash
uv pip install jupyter
```

### 3. Render or Preview the Site

- To render all lectures and build the site:
	```bash
	quarto render
	```
- To preview the site locally (auto-reloads on changes):
	```bash
	quarto preview
	```

### 4. Edit Content

- Edit Jupyter notebooks in the `lectures/` folder as needed.

---

For more information, see the [Quarto documentation](https://quarto.org/docs/presentations/revealjs/).

## Requirements
- [Quarto](https://quarto.org/)
- [Jupyter](https://jupyter.org/)
- Python 3.x and required packages for your lectures.

## Lectures
- 12 template notebooks are provided, one for each week.

---

For more information, see the [Quarto documentation](https://quarto.org/docs/presentations/revealjs/).

