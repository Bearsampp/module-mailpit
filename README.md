<div align="center"><a href="https://bearsampp.com/contribute" target="_blank"><img width="250" src="img/Bearsampp-logo.svg"></a></div>

[![GitHub release](https://img.shields.io/github/release/bearsampp/module-mailpit.svg?style=flat-square)](https://github.com/bearsampp/module-mailpit/releases/latest)
![Total downloads](https://img.shields.io/github/downloads/bearsampp/module-mailpit/total.svg?style=flat-square)

This is a module of [Bearsampp project](https://github.com/bearsampp/bearsampp) involving mailpit.

## Building
This module uses a pure Gradle build system:

```bash
gradle releaseBuild
```

Interactive build with automatic version selection and download. The build system:
- ✅ Checks `bin/` and `bin/archived/` directories for local versions
- ✅ Falls back to `releases.properties` for download URLs
- ✅ Automatically downloads from modules-untouched repository if needed
- ✅ Generates release archives with checksums (MD5, SHA1, SHA256, SHA512)

### Quick Start

```bash
# Interactive build (recommended)
gradle releaseBuild

# Or use the convenience script
build-release.bat

# List available tasks
gradle tasks

# Clean build artifacts
gradle cleanBuild
```

### Documentation

Complete documentation is available in [.gradle-docs/](.gradle-docs/):
- **[QUICK_START.md](.gradle-docs/QUICK_START.md)** - Get started in 2 minutes
- **[GRADLE_INDEX.md](.gradle-docs/GRADLE_INDEX.md)** - Documentation index
- **[BUILD_FLOW.md](.gradle-docs/BUILD_FLOW.md)** - Visual diagrams and process flows
- **[MIGRATION_NOTES.md](.gradle-docs/MIGRATION_NOTES.md)** - Migration details from Ant

## Documentation and downloads

https://bearsampp.com/module/mailpit

## Issues

Issues must be reported on [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).

## Statistics
![Alt](https://repobeats.axiom.co/api/embed/4df99c2d3004fdc34ec7d97c88c1e08c9d602149.svg "Repobeats analytics image")
