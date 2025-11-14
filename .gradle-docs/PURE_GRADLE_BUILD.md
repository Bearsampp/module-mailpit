# Pure Gradle Build System

## Overview

The module-mailpit project now uses a **pure Gradle build system**. All Ant build files have been removed, and the project is fully managed through Gradle.

## What Changed

### Removed Files
- ❌ `build.xml` - Ant build file (removed)
- ❌ Dependencies on external `build-commons.xml` and `build-bundle.xml`

### Current Build System
- ✅ `build.gradle` - Complete build logic
- ✅ `settings.gradle` - Project settings
- ✅ `build.properties` - Configuration (unchanged)
- ✅ `releases.properties` - Version mappings (unchanged)
- ✅ `.gradle-docs/` - Complete documentation

## Quick Start

```bash
# Interactive build
gradle releaseBuild

# Or use the convenience script
build-release.bat

# List available tasks
gradle tasks

# Clean build artifacts
gradle cleanBuild
```

## Key Features

### 1. Interactive Version Selection
```
=== Bearsampp Module Builder - mailpit ===
Available versions:
============================================================
1. 1.18.7 [releases]
2. 1.20.3 [releases]
...
18. 1.27.9 [releases, bin]
19. 1.27.10 [releases, bin, archived]

Enter version number (or type version directly, or 'custom' for unlisted version):
>
```

### 2. Automatic Version Discovery
The build system automatically checks:
- ✅ `bin/` directory for local versions
- ✅ `bin/archived/` directory for archived versions
- ✅ `releases.properties` for download URLs
- ✅ modules-untouched repository as fallback

### 3. Smart Download Management
- Downloads only when needed
- Uses local versions when available
- Falls back to remote sources automatically
- Caches downloads to avoid re-downloading

### 4. Complete Build Pipeline
```
verifyDevProject → selectVersion → downloadModule → prepareBundle → createRelease
```

## Available Tasks

| Task          | Description                                    |
|---------------|------------------------------------------------|
| releaseBuild  | Main build task (interactive)                  |
| release       | Alias for releaseBuild                         |
| selectVersion | Interactive version selection                  |
| downloadModule| Download and extract module                    |
| prepareBundle | Prepare bundle directory                       |
| createRelease | Create release archive with checksums          |
| cleanBuild    | Clean temporary build files                    |
| tasks         | List all available tasks                       |

## Configuration

### build.properties
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z

# Optional: Custom build path
#build.path = C:/Bearsampp-build
```

### Environment Variables
```bash
# Optional: Set custom build path
set BEARSAMPP_BUILD_PATH=D:/MyBuilds
```

## Build Output

### Directory Structure
```
C:/Bearsampp-build/
└── bins/
    └── mailpit/
        └── 2025.10.14/
            ├── bearsampp-mailpit-1.27.10-2025.10.14.7z
            ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.md5
            ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha1
            ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha256
            └── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha512
```

### Generated Files
- **Archive**: `.7z` or `.zip` format
- **Checksums**: MD5, SHA1, SHA256, SHA512

## Version Resolution

### Priority Order
1. **Local bin/ directory** - If version exists with `mailpit.exe`
2. **Local bin/archived/ directory** - If version exists
3. **releases.properties** - Download URL mapping
4. **modules-untouched repository** - Fallback source

### Example Flow
```
User selects version 1.27.10
  ↓
Check bin/mailpit1.27.10/mailpit.exe
  ↓ (not found)
Check bin/archived/mailpit1.27.10/
  ↓ (not found)
Check releases.properties
  ↓ (found URL)
Download from URL
  ↓
Extract archive
  ↓
Verify mailpit.exe
  ↓
Prepare bundle
  ↓
Create release archive
```

## Advanced Usage

### Non-Interactive Build
```bash
# Specify version via command line
gradle releaseBuild -PbundleVersion=1.27.10
```

### Custom Version
```bash
# During interactive prompt, type 'custom'
> custom
Enter custom version:
> 1.28.0
```

### Custom Build Path
```bash
# Method 1: Edit build.properties
build.path = D:/MyBuilds

# Method 2: Environment variable
set BEARSAMPP_BUILD_PATH=D:/MyBuilds
gradle releaseBuild

# Method 3: Command line (not currently supported, use methods 1 or 2)
```

## Troubleshooting

### Common Issues

#### "Project 'dev' not found"
**Solution**: Ensure `../dev` directory exists relative to the project

#### "Version not found"
**Solution**: 
- Check spelling of version number
- Use 'custom' option to enter version manually
- Verify version exists in releases.properties or modules-untouched

#### "7z command not found"
**Solution**: 
- Install 7-Zip from https://www.7-zip.org/
- Add 7-Zip to system PATH
- Or set `7Z_HOME` environment variable

#### "mailpit.exe not found"
**Solution**:
- Check archive structure
- Verify download completed successfully
- Check extraction log for errors

### Debug Mode
```bash
# Run with stack trace for detailed errors
gradle releaseBuild --stacktrace

# Run with debug output
gradle releaseBuild --debug
```

## Documentation

### Complete Documentation Set
All documentation is located in `.gradle-docs/`:

| Document                      | Purpose                           |
|-------------------------------|-----------------------------------|
| README.md                     | Documentation overview            |
| QUICK_START.md                | 2-minute quick start guide        |
| GRADLE_INDEX.md               | Documentation index               |
| BUILD_FLOW.md                 | Visual diagrams and flows         |
| MIGRATION_NOTES.md            | Ant to Gradle migration details   |
| GRADLE_COMPLETE.md            | Complete feature summary          |
| CONVERSION_CHECKLIST.md       | Task checklist                    |
| GRADLE_CONVERSION_SUMMARY.md  | High-level summary                |
| PURE_GRADLE_BUILD.md          | This document                     |

### Quick Links
- **New user?** → [QUICK_START.md](QUICK_START.md)
- **Need details?** → [GRADLE_INDEX.md](GRADLE_INDEX.md)
- **Understand flow?** → [BUILD_FLOW.md](BUILD_FLOW.md)
- **Migration info?** → [MIGRATION_NOTES.md](MIGRATION_NOTES.md)

## Requirements

### System Requirements
- ☕ **Java 8+** - Required for Gradle
- 🔧 **Gradle** - Use system Gradle or included wrapper
- 📦 **7-Zip** - Required for .7z format archives
- 💻 **Windows** - Primary platform (PowerShell/CMD)

### Project Requirements
- 📁 **dev project** - Must exist in `../dev` directory
- 📄 **build.properties** - Build configuration
- 📄 **releases.properties** - Version mappings (optional)

## Benefits of Pure Gradle

### For Developers
- ✅ Modern, familiar build tool
- ✅ Better IDE integration (IntelliJ, Eclipse, VS Code)
- ✅ Interactive, user-friendly interface
- ✅ Clear error messages
- ✅ Incremental builds

### For Maintainers
- ✅ Single build script (build.gradle)
- ✅ No external dependencies (build-commons.xml, etc.)
- ✅ Easy to understand and modify
- ✅ Comprehensive documentation
- ✅ Standard Gradle conventions

### For CI/CD
- ✅ Standard Gradle commands
- ✅ Non-interactive mode support
- ✅ Consistent output format
- ✅ Easy integration with CI systems
- ✅ Reproducible builds

## Comparison with Ant

| Feature                  | Ant Build | Gradle Build |
|--------------------------|-----------|--------------|
| Interactive selection    | ❌        | ✅           |
| Automatic fallback       | ❌        | ✅           |
| External dependencies    | ✅        | ❌           |
| Modern tooling           | ❌        | ✅           |
| IDE integration          | Limited   | Excellent    |
| Error messages           | Basic     | Detailed     |
| Documentation            | Minimal   | Comprehensive|
| Maintenance              | Complex   | Simple       |

## Migration Complete

✅ **Status**: Pure Gradle build system is fully operational

### What Was Done
- ✅ Removed all Ant build files
- ✅ Integrated all build logic into build.gradle
- ✅ Updated all documentation
- ✅ Aligned table columns and formatting
- ✅ Organized documentation in .gradle-docs/
- ✅ Maintained 100% output compatibility

### What Remains Unchanged
- ✅ build.properties format
- ✅ releases.properties format
- ✅ Output archive format
- ✅ Directory structure
- ✅ Bundle preparation logic
- ✅ Checksum generation

## Support

### Getting Help
1. **Check documentation** - Most questions are answered in `.gradle-docs/`
2. **Try the build** - Hands-on learning is best
3. **Read error messages** - They're designed to be helpful
4. **Report issues** - https://github.com/bearsampp/bearsampp/issues

### Useful Commands
```bash
# List all tasks
gradle tasks

# Get help on a specific task
gradle help --task releaseBuild

# Run with detailed output
gradle releaseBuild --info

# Run with debug output
gradle releaseBuild --debug
```

## Future Enhancements

Potential improvements for future versions:

1. **Parallel Builds** - Build multiple versions simultaneously
2. **Advanced Caching** - Smart cache management for downloads
3. **Checksum Verification** - Verify downloaded archives
4. **GitHub Integration** - Direct publishing to GitHub releases
5. **Automated Testing** - Test built modules automatically
6. **Custom Plugins** - Bearsampp-specific Gradle plugins
7. **Build Profiles** - Different configurations for different scenarios
8. **Dependency Management** - Manage module dependencies

## Conclusion

The pure Gradle build system provides:
- ✅ Modern, maintainable build infrastructure
- ✅ User-friendly interactive experience
- ✅ Automatic version discovery and download
- ✅ Comprehensive documentation
- ✅ 100% compatibility with previous builds
- ✅ Easy to extend and customize

The migration is complete and the project is ready for production use.

---

**Happy Building!** 🚀

*For more information, see the complete documentation in `.gradle-docs/`*
