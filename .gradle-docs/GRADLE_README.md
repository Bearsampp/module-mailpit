# Gradle Build System

This module has been converted to use Gradle following Bruno's build methods.

## Quick Start

```bash
gradle releaseBuild
```

## Features

✅ **Interactive Version Selection**
- Shows versions from `releases.properties`
- Shows versions from `bin/` directory
- Shows versions from `bin/archived/` directory
- Indicates source for each version (e.g., `[releases, bin, archived]`)

✅ **Smart Version Resolution**
- Uses local version from `bin/` if available
- Uses archived version from `bin/archived/` if available
- Downloads from `releases.properties` if not local
- Falls back to modules-untouched repository

✅ **Bruno's Build Methods**
- Property-based configuration
- Version management
- Bundle preparation
- Archive creation

## Documentation

All Gradle documentation is in **[.gradle-docs/](.gradle-docs/)**

- [Quick Start](QUICK_START.md) - 2-minute guide
- [Complete Guide](GRADLE_INDEX.md) - Full documentation index
- [Migration Notes](MIGRATION_NOTES.md) - Ant to Gradle details

## Example

```
=== Bearsampp Module Builder - mailpit ===
Available versions:
============================================================
1. 1.18.7 [releases, archived]
2. 1.20.3 [releases, archived]
...
18. 1.27.9 [releases, bin]
19. 1.27.10 [releases, bin]

Enter version number (or type version directly, or 'custom' for unlisted version):
> 18

Selected version: 1.27.9
Using local version from: bin/mailpit1.27.9
Using local version, skipping download
Preparing bundle...
Creating release archive...

============================================================
Release created successfully!
Archive: C:/Bearsampp-build/release/bearsampp-mailpit-1.27.9-2025.10.14.7z
Size: 12.34 MB
============================================================
```

## Configuration

Edit `build.properties`:
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z
```

## Requirements

- Java 8+
- Gradle (no wrapper, use system Gradle)
- 7-Zip (for .7z archives)

## Support

See [.gradle-docs/](.gradle-docs/) for complete documentation.
