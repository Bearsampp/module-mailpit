# Gradle Build Documentation

Welcome to the Gradle build documentation for module-mailpit!

This module uses a **100% pure Gradle build system** with complete feature parity with the bruno module.

## 📚 Documentation Files

### Quick Start
- **[QUICK_START.md](QUICK_START.md)** - Get started in 2 minutes
- **[PURE_GRADLE_BUILD.md](PURE_GRADLE_BUILD.md)** - Pure Gradle build overview

### Complete Guides
- **[GRADLE_INDEX.md](GRADLE_INDEX.md)** - Documentation index and navigation
- **[GRADLE_COMPLETE.md](GRADLE_COMPLETE.md)** - Complete conversion summary
- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)** - Ant to Gradle migration details
- **[BUILD_FLOW.md](BUILD_FLOW.md)** - Visual diagrams and process flows

### Reference
- **[GRADLE_CONVERSION_SUMMARY.md](GRADLE_CONVERSION_SUMMARY.md)** - Feature summary
- **[CONVERSION_CHECKLIST.md](CONVERSION_CHECKLIST.md)** - Task checklist

## 🚀 Quick Start

```bash
# Interactive build (shows version menu)
gradle release

# Non-interactive build (specify version)
gradle release "-PbundleVersion=1.27.10"
```

The build will:
1. Show available versions from `bin/`, `bin/archived/`, and modules-untouched
2. Let you select a version interactively (or use specified version)
3. Use local version if available, or download from modules-untouched
4. Prepare the bundle with bearsampp.conf overlay
5. Create the release archive with hash files (MD5, SHA1, SHA256, SHA512)

## 🎯 Key Features

### Build Modes
- ✅ **Interactive mode** - User-friendly version selection menu
- ✅ **Non-interactive mode** - Perfect for CI/CD pipelines
- ✅ **Batch mode** - Build all versions with `gradle releaseAll`

### Version Management
- ✅ Checks `bin/` directory for local versions
- ✅ Checks `bin/archived/` directory for archived versions
- ✅ Fetches from modules-untouched repository automatically
- ✅ Caches downloads for faster subsequent builds
- ✅ Supports version selection by index or version string

### Build Features
- ✅ **No Ant dependency** - Pure Gradle implementation
- ✅ **Auto-download** - Fetches binaries from modules-untouched
- ✅ **Hash generation** - MD5, SHA1, SHA256, SHA512
- ✅ **Overlay support** - Merges bearsampp.conf from bin/
- ✅ **Archive formats** - Both 7z and zip supported
- ✅ **Build caching** - Reuses downloaded files
- ✅ **Parallel builds** - Gradle's built-in parallelization

### Output Structure
```
bearsampp-build/
├── bins/
│   └── mailpit/
│       └── 2025.10.14/
│           ├── bearsampp-mailpit-1.27.10-2025.10.14.7z
│           ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.md5
│           ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha1
│           ├── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha256
│           └── bearsampp-mailpit-1.27.10-2025.10.14.7z.sha512
└── tmp/
    ├── bundles_build/
    │   └── bins/
    │       └── mailpit/
    │           └── mailpit1.27.10/  (uncompressed version)
    ├── bundles_prep/
    │   └── bins/
    │       └── mailpit/
    │           └── mailpit1.27.10/  (prepared files)
    ├── downloads/
    │   └── mailpit/
    │       └── mailpit-windows-amd64.zip  (cached download)
    └── extract/
        └── mailpit/
            └── 1.27.10/  (extracted binaries)
```

## 📖 Where to Start

1. **New user?** → Start with [QUICK_START.md](QUICK_START.md)
2. **Need details?** → Read [GRADLE_INDEX.md](GRADLE_INDEX.md)
3. **Migrating from Ant?** → See [MIGRATION_NOTES.md](MIGRATION_NOTES.md)
4. **Want to understand the flow?** → Check [BUILD_FLOW.md](BUILD_FLOW.md)

## 💡 Example Interactive Session

```
================================================================
  Bearsampp Module Mailpit - Gradle Build
================================================================

> Task :release

======================================================================
Available mailpit versions:
======================================================================
   1. 1.18.7          [bin/archived]
   2. 1.20.3          [bin/archived]
   3. 1.20.4          [bin/archived]
   4. 1.20.5          [bin/archived]
   5. 1.20.6          [bin/archived]
   6. 1.20.7          [bin/archived]
   7. 1.21.1          [bin/archived]
   8. 1.21.5          [bin/archived]
   9. 1.21.6          [bin/archived]
  10. 1.21.7          [bin/archived]
  11. 1.22.0          [bin/archived]
  12. 1.22.2          [bin/archived]
  13. 1.22.3          [bin/archived]
  14. 1.23.0          [bin/archived]
  15. 1.24.1          [bin/archived]
  16. 1.24.2          [bin/archived]
  17. 1.26.0          [bin/archived]
  18. 1.27.0          [bin]
  19. 1.27.5          [bin]
  20. 1.27.9          [bin]
  21. 1.27.10         [bin]

Enter version to build (index or version string):

> 21

Selected version: 1.27.10

======================================================================
Building release for mailpit version 1.27.10
======================================================================

Bundle path: D:\Bearsampp-dev\module-mailpit\bin\mailpit1.27.10

Mailpit binaries not found
Downloading Mailpit 1.27.10...

Checking modules-untouched repository...
Fetching mailpit.properties from modules-untouched repository...
  ✓ Successfully loaded 21 versions from modules-untouched
Found version 1.27.10 in modules-untouched mailpit.properties
  Download complete from modules-untouched
  Extraction complete
  Found Mailpit directory: 1.27.10

Copying Mailpit files...
Copying bearsampp.conf...

Preparing archive...
Archive created: D:\Bearsampp-dev\bearsampp-build\bins\mailpit\2025.10.14\bearsampp-mailpit-1.27.10-2025.10.14.7z
Generating hash files...
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.md5
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha1
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha256
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha512

======================================================================
[SUCCESS] Release build completed successfully for version 1.27.10
======================================================================

BUILD SUCCESSFUL in 4s
```

## 🔧 Available Tasks

### Build Tasks
```bash
gradle release                              # Interactive or non-interactive release
gradle release "-PbundleVersion=1.27.10"    # Build specific version
gradle releaseAll                           # Build all available versions
```

### Information Tasks
```bash
gradle info                                 # Display build configuration
gradle listVersions                         # List versions in bin/ directories
gradle listReleases                         # List releases from modules-untouched
gradle tasks                                # List all available tasks
```

### Verification Tasks
```bash
gradle verify                               # Verify build environment
gradle validateProperties                   # Validate build.properties
gradle checkModulesUntouched                # Check modules-untouched integration
```

### Maintenance Tasks
```bash
gradle clean                                # Clean build artifacts
```

## 🔧 Configuration

Edit `build.properties`:
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z
build.path = D:/Bearsampp-build  # Optional, defaults to ../bearsampp-build
```

### Environment Variables

You can also use environment variables:
```bash
set BEARSAMPP_BUILD_PATH=D:/MyBuilds
set 7Z_HOME=C:/Program Files/7-Zip
```

## 🎨 Build System Architecture

The build system follows this flow:

1. **Version Discovery**
   - Scans `bin/` directory
   - Scans `bin/archived/` directory
   - Fetches from modules-untouched (optional)

2. **Source Resolution**
   - Uses local version if available
   - Downloads from modules-untouched if needed
   - Caches downloads for reuse

3. **Bundle Preparation**
   - Copies mailpit binaries
   - Overlays bearsampp.conf from bin/
   - Creates uncompressed version in bundles_build

4. **Archive Creation**
   - Compresses using 7-Zip or Gradle zip
   - Generates hash files (MD5, SHA1, SHA256, SHA512)
   - Outputs to `bearsampp-build/{bundleType}/{bundleName}/{bundleRelease}/`

## 🚀 Advanced Usage

### Build All Versions
```bash
gradle releaseAll
```

### Custom Build Path
```bash
gradle release "-PbundleVersion=1.27.10" "-Pbuild.path=D:/CustomPath"
```

### Check Available Versions Remotely
```bash
gradle listReleases
```

### Verify Environment Before Building
```bash
gradle verify
```

## 📊 Build Performance

- **First build**: Downloads and extracts (~30 seconds)
- **Subsequent builds**: Uses cache (~5 seconds)
- **Parallel builds**: Gradle handles parallelization automatically

## 🔍 Troubleshooting

See [QUICK_START.md](QUICK_START.md) for common issues and solutions.

## 📞 Support

- Full documentation: See files in this directory
- Issues: https://github.com/bearsampp/bearsampp/issues
- Module info: https://bearsampp.com/module/mailpit

## 🎯 Feature Parity with Bruno

This build system has **complete feature parity** with the bruno module:

✅ Interactive mode with version menu
✅ Non-interactive mode for CI/CD
✅ Auto-download from modules-untouched
✅ Caching of downloads
✅ Hash file generation
✅ Overlay support
✅ Batch building
✅ Version discovery
✅ Pure Gradle (no Ant)

---

**Happy Building!** 🚀
