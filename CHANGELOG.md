# Changelog

All notable changes to this project will be documented in this file.

## [2025-11-29] - Guides Structure & Demo Scripts

### Added
- Created 11 lab modules under `Labs/guides/` (000-setup through 010-monitoring)
- Each module includes:
  - `README.md` with learning objectives and tasks
  - `_demo.sh` CI-friendly demo script for smoke testing
- Updated `mkdocs/06-mkdocs-nav.yml` to include only the new module READMEs in order

### Changed
- All demo scripts are now non-destructive and skip gracefully when tooling (oc, kubectl, docker) is missing or not authenticated
- Simplified navigation structure to focus on the course workplan modules

### Technical Details
- Demo scripts use consistent template with `info()` and `warn()` functions
- Scripts return exit code 0 even when tools are missing, making them CI-friendly
- Each module follows the proposed course workplan from the main README

