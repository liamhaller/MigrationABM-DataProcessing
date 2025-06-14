# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
Migration ABM Data Processing - R codebase for processing migration data for an agent-based model simulating Turkey-Germany migration patterns.

## Run Commands
- Main script: `source("mainscript.R")`
- Individual data processing: `source("data_processing/[script_name].R")` 

## Packages
Use the `packagemanager.R` script to handle dependencies. New packages should be added to the `required_packages` list in this file.

## Code Style Guidelines
- **Naming**: Use snake_case for variables and functions
- **Formatting**: Use blank lines to separate logical sections
- **Comments**: Use `#` with section headers using `# Section name -------------------`
- **Package import**: Source packagemanager.R at the beginning of scripts
- **File paths**: Use the `here()` package for path management
- **Data objects**: Store processed data as .rds files in data/processed/
- **Functions**: Define helper functions in functions.R or within scripts as needed
- **Error handling**: Use base R error messaging; formal error handling not required

## Data Processing Pattern
Follow existing patterns in data_processing/ scripts when adding new data sources.