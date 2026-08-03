# Hot-Dry & Hot-Wet Compound Events

This repository provides a comprehensive guide for computing hot-dry and hot-wet compound climate events. It accompanies the results presented in our study and walks the user through every step, from raw data loading and bias correction to the final compound event characterization metrics.

The repository is configured to run entirely from GitHub using **GitHub Codespaces**, requiring no local installation.

---

## Contents

### Jupyter Notebooks
- **`load.data.and.bias.adjustment.ipynb`** — Load climate data and apply bias adjustment corrections
- **`hot.dry.hot.wet.compound.events.ipynb`** — Calculate and analyze hot-dry and hot-wet compound events

### R Scripts
- **`hot.dry.hot.wet.compound.events.R`** — R implementation for calculating hot-dry and hot-wet compound events

### Data & Configuration
- **`data/`** — Directory containing input climate data
- **`functions/`** — Helper functions used across the analysis
- **`data_inventory.csv`** — Inventory of the input data files

---

## Getting Started

### 1. Launch a GitHub Codespace

This repository is pre-configured to run in a cloud-based development environment via GitHub Codespaces — no local setup required.

To launch it:

1. Navigate to the repository main page on GitHub.
2. Click the green **`<> Code`** button in the upper-right corner.
3. Select the **Codespaces** tab.
4. Click **"Create codespace on main"**.

GitHub will build and open a fully configured environment in your browser. This may take a few minutes on the first launch.

### 2. Activate the Conda Environment

Once the Codespace is ready, open a terminal (`` Ctrl+` `` or via the top menu: **Terminal → New Terminal**) and activate the pre-configured environment:

```bash
conda activate compound
```

### 3. Install the `remotes` R Package

This step is required before running any R script or Jupyter Notebook. Start an R session from the terminal:

```bash
R
```

Then install the `remotes` package:

```r
install.packages("remotes")
```

> **Note:** Because the default system library is not user-writable, R will prompt you twice. Type `yes` both times:
>
> ```
> Warning in install.packages("remotes") :
>   'lib = "/opt/conda/envs/compound/lib/R/library"' is not writable
> Would you like to use a personal library instead? (yes/No/cancel) yes
> Would you like to create a personal library
> '/home/vscode/R/x86_64-conda-linux-gnu-library/4.3'
> to install packages into? (yes/No/cancel) yes
> ```
>
> You will then be prompted to select a CRAN mirror — choose the one closest to your location.

Once the installation is complete, exit R:

```r
q()
```

---

## Workflow

After completing the setup above, follow these steps to reproduce the results:

1. **Load data and apply bias correction**
   Open and run `load.data.and.bias.adjustment.ipynb` to load the climate data and apply the necessary bias corrections.

2. **Characterize compound events**
   Open and run `hot.dry.hot.wet.compound.events.ipynb` (or equivalently, execute `hot.dry.hot.wet.compound.events.R`) to compute all compound event metrics presented in the article.

