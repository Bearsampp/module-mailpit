# Quick Start - Gradle Build

## TL;DR

```bash
# Interactive build (recommended)
gradle release

# Non-interactive build
gradle release "-PbundleVersion=1.27.10"
```

## What Happens?

1. 📋 Shows you a list of available versions from bin/ directories
2. ✅ You select a version (by number or version string)
3. 📥 Downloads the version automatically if not present locally
4. 📦 Prepares the bundle with bearsampp.conf overlay
5. 🗜️ Creates the release archive with hash files
6. ✨ Done!

## Example Interactive Session

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
   ...
  18. 1.27.5          [bin]
  19. 1.27.9          [bin]
  20. 1.27.10         [bin]

Enter version to build (index or version string):

> 20

Selected version: 1.27.10

======================================================================
Building release for mailpit version 1.27.10
======================================================================

Bundle path: D:\Bearsampp-dev\module-mailpit\bin\mailpit1.27.10

Mailpit binaries not found
Downloading Mailpit 1.27.10...

Checking modules-untouched repository...
Fetching mailpit.properties from modules-untouched repository...
  URL: https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/mailpit.properties
  ✓ Successfully loaded 21 versions from modules-untouched
Found version 1.27.10 in modules-untouched mailpit.properties
Downloading from:
  https://github.com/Bearsampp/modules-untouched/releases/download/mailpit-2025.10.14/mailpit-windows-amd64.zip
  Downloading to: D:\Bearsampp-dev\bearsampp-build\tmp\downloads\mailpit\mailpit-windows-amd64.zip
  Download complete from modules-untouched
  Extracting archive...
  Extraction complete
  Found Mailpit directory: 1.27.10

NOTE: Version 1.27.10 was sourced from modules-untouched (or fallback URL).
Source folder: D:\Bearsampp-dev\bearsampp-build\tmp\extract\mailpit\1.27.10

Copying Mailpit files...
Copying bearsampp.conf...

Copying to bundles_build directory...
Non-zip version available at: D:\Bearsampp-dev\bearsampp-build\tmp\bundles_build\bins\mailpit\mailpit1.27.10

Preparing archive...
Using 7-Zip: C:\Program Files\7-Zip\7z.exe
Compressing mailpit1.27.10 to bearsampp-mailpit-1.27.10-2025.10.14.7z...

Archive created: D:\Bearsampp-dev\bearsampp-build\bins\mailpit\2025.10.14\bearsampp-mailpit-1.27.10-2025.10.14.7z
Generating hash files...
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.md5
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha1
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha256
  Created: bearsampp-mailpit-1.27.10-2025.10.14.7z.sha512

======================================================================
[SUCCESS] Release build completed successfully for version 1.27.10
Output directory: D:\Bearsampp-dev\bearsampp-build\tmp\bundles_build\bins\mailpit
Archive: D:\Bearsampp-dev\bearsampp-build\bins\mailpit\2025.10.14\bearsampp-mailpit-1.27.10-2025.10.14.7z
======================================================================

BUILD SUCCESSFUL in 4s
```

## Non-Interactive Build

For CI/CD or scripting:

```bash
gradle release "-PbundleVersion=1.27.10"
```

## Version Selection Options

You can enter:
- **Index number**: `20` (selects version at position 20)
- **Version string**: `1.27.10` (selects specific version)

## Requirements

- ☕ Java 8+
- 🔧 Gradle (wrapper included)
- 📦 7-Zip (for .7z archives, optional for .zip)

## Output Location

Archives are created in:
```
{buildBasePath}/{bundleType}/{bundleName}/{bundleRelease}/
```

Default:
```
D:/Bearsampp-dev/bearsampp-build/bins/mailpit/2025.10.14/bearsampp-mailpit-{version}-2025.10.14.7z
```

With hash files:
- `.md5` - MD5 checksum
- `.sha1` - SHA1 checksum
- `.sha256` - SHA256 checksum
- `.sha512` - SHA512 checksum

## Available Tasks

```bash
# Build tasks
gradle release                              # Interactive or non-interactive release
gradle releaseAll                           # Build all available versions

# Information tasks
gradle info                                 # Display build configuration
gradle listVersions                         # List versions in bin/ directories
gradle listReleases                         # List releases from modules-untouched

# Verification tasks
gradle verify                               # Verify build environment
gradle validateProperties                   # Validate build.properties
gradle checkModulesUntouched                # Check modules-untouched integration

# Maintenance tasks
gradle clean                                # Clean build artifacts
```

## Clean Up

```bash
gradle clean
```

This removes the local `build/` directory but preserves cached downloads in `bearsampp-build/tmp/`.

## Need Help?

- 📖 Full docs: [README.md](README.md)
- 📊 Build flow: [BUILD_FLOW.md](BUILD_FLOW.md)
- 🔄 Migration info: [MIGRATION_NOTES.md](MIGRATION_NOTES.md)
- 🐛 Issues: https://github.com/bearsampp/bearsampp/issues

## Pro Tips

💡 **Tip 1**: Cached downloads speed up subsequent builds
```bash
# First build downloads
gradle release "-PbundleVersion=1.27.10"

# Second build uses cache (much faster!)
gradle release "-PbundleVersion=1.27.10"
```

💡 **Tip 2**: Set custom build path in build.properties
```properties
build.path = D:/MyBuilds
```

💡 **Tip 3**: Use environment variable for build path
```bash
set BEARSAMPP_BUILD_PATH=D:/MyBuilds
gradle release
```

💡 **Tip 4**: Build all versions at once
```bash
gradle releaseAll
```

💡 **Tip 5**: Check what versions are available remotely
```bash
gradle listReleases
```

💡 **Tip 6**: Verify your environment before building
```bash
gradle verify
```

## Troubleshooting

❌ **"Project 'dev' not found"**
→ Make sure `../dev` directory exists relative to module-mailpit

❌ **"Bundle version not found"**
→ Run `gradle listVersions` to see available versions

❌ **"7-Zip executable not found"**
→ Install 7-Zip or set `7Z_HOME` environment variable

❌ **"mailpit.exe not found"**
→ Build will automatically download from modules-untouched

❌ **"Failed to download from modules-untouched"**
→ Check internet connection or verify version exists in modules-untouched

❌ **"Java version too old"**
→ Requires Java 8 or higher

## Build System Features

✅ **No Ant Dependency** - Pure Gradle build
✅ **Interactive Mode** - User-friendly version selection
✅ **Non-Interactive Mode** - Perfect for CI/CD
✅ **Auto-Download** - Fetches binaries from modules-untouched
✅ **Caching** - Reuses downloaded files
✅ **Hash Generation** - MD5, SHA1, SHA256, SHA512
✅ **Overlay Support** - Merges bearsampp.conf from bin/
✅ **Archive Support** - Both 7z and zip formats
✅ **Batch Building** - Build all versions with one command
✅ **Version Discovery** - Checks bin/, bin/archived/, and modules-untouched

## That's It! 🎉

The Gradle build handles everything automatically. Just run `gradle release` and select a version!
