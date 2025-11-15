<div align="center"><a href="https://bearsampp.com/contribute" target="_blank"><img width="250" src="img/Bearsampp-logo.svg"></a></div>

[![GitHub release](https://img.shields.io/github/release/bearsampp/module-mailpit.svg?style=flat-square)](https://github.com/bearsampp/module-mailpit/releases/latest)
![Total downloads](https://img.shields.io/github/downloads/bearsampp/module-mailpit/total.svg?style=flat-square)

This is a module of [Bearsampp project](https://github.com/bearsampp/bearsampp) involving mailpit.

## Building
This module uses a 100% pure Gradle build system with no Ant dependencies:

```bash
# Interactive build (recommended)
gradle release

# Non-interactive build
gradle release "-PbundleVersion=1.27.10"
```

The build system features:
- ✅ Interactive version selection with numbered menu
- ✅ Checks `bin/` and `bin/archived/` directories for local versions
- ✅ Automatically downloads from modules-untouched repository if needed
- ✅ Generates release archives with checksums (MD5, SHA1, SHA256, SHA512)
- ✅ Caches downloads for faster subsequent builds
- ✅ Supports both 7z and zip archive formats

### Quick Start

```bash
# Interactive build (shows version menu)
gradle release

# Non-interactive build (specify version)
gradle release "-PbundleVersion=1.27.10"

# Build all available versions
gradle releaseAll

# List available versions
gradle listVersions

# List releases from modules-untouched
gradle listReleases

# Verify build environment
gradle verify

# Display build information
gradle info

# Clean build artifacts
gradle clean
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
