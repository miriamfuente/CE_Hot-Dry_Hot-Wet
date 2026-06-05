# Hot-Dry & Hot-Wet Compound Events

In this repository, you will find a comprehensive guide on obtaining compound events categorized as hot-dry and hot-wet. You will be guided through the calculation of all metrics until you arrive at the final results.

## Contents

### Jupyter Notebooks
- **load.data.and.bias.adjustment.ipynb** - Load climate data and apply bias adjustment corrections
- **hot.dry.hot.wet.compound.events.ipynb** - Calculate and analyze hot-dry and hot-wet compound events

### R Scripts
- **hot.dry.hot.wet.compound.events.R** - R implementation for calculating hot-dry and hot-wet compound events

### Data & Configuration
- **data/** - Directory containing input climate data
- **functions/** - Helper functions used across the analysis

## Workflow

1. Start with `load.data.and.bias.adjustment.ipynb` to load the climate data and apply bias correction to it
2. Run `hot.dry.hot.wet.compound.events.ipynb` (or use the R script) to characterize compound events (with all metrics shown in the article)

For more details, refer to the individual notebooks and scripts.

This repository was created to reproduce the results obtained in our study. It has been configured to run directly from GitHub using the codespaces option.
