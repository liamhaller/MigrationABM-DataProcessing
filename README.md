# Turkish-German Labor Migration Simulation

## Overview
This repository contains data processing scripts, documentation, and parameterization tools for an agent-based model (ABM) simulating high-skilled migration between Turkey and Germany. The model aims to investigate the efficacy of policy changes on labor migration outcomes between these countries using the Theory of Planned Behavior framework.

## Repository Structure
- `data/`: Raw datasets from various sources
- `data_processing/`: R scripts for cleaning and preprocessing datasets
- `parameterization/`: Parameter estimation and calibration tools in R
- `visualization/`: R tools for visualizing data and model outputs
- `docs/`: Documentation including the data appendix and model specification
- `R/`: Custom R functions and utilities for the project

## Data Sources
This repository integrates multiple datasets including:
- DEMIG Policy Data (migration policy restrictiveness)
- IMPIC (Immigration Policies in Comparison)
- Destatis (German statistical office data on residence permits and migration flows)
- OECD Reports on Migration in Turkey
- EUMAGINE Survey (migration aspirations and capabilities data)
- TurkStat (Turkish Statistical Institute) emigration statistics
- Social network data on international connections

## Model Overview
The agent-based model simulates migration decisions of heterogeneous agents representing Turkish citizens who can develop migration aspirations. The model uses:

- Theory of Planned Behavior framework for migration decision-making
- Five-stage migration process (no intention, intention, planning, preparation, migration)
- Network effects and information sharing among agents
- Exogenous policy changes and economic/political factors
- Regional variation in migration patterns

## Usage
The outputs from this repository serve as inputs to the migration simulation model. The processed data and estimated parameters will be exported in formats ready for integration with the simulation software.


