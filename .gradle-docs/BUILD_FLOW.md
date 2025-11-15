# Build Flow Documentation

This document describes the complete build flow for the module-mailpit Gradle build system.

## Overview

The build system is a **100% pure Gradle implementation** with no Ant dependencies, featuring automatic download capabilities and complete feature parity with the bruno module.

## Build Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                     gradle release                              │
│                  (Interactive or Non-Interactive)               │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
                    ┌────────────────┐
                    │ Version Param? │
                    └────────┬───���───┘
                             │
                ┌────────────┴────────────┐
                │                         │
            No  │                         │ Yes
                ▼                         ▼
    ┌───────────────────────┐   ┌────────────────────┐
    │  Interactive Mode     │   │ Non-Interactive    │
    │  - Show version menu  │   │ - Use specified    │
    │  - Read user input    │   │   version          │
    │  - Validate selection │   │                    │
    └───────────┬───────────┘   └─────────┬──────────┘
                │                         │
                └────────────┬────────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Version Discovery     │
                │  1. bin/               │
                │  2. bin/archived/      │
                └────────────┬──────���────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Check Local Version   │
                │  mailpit.exe exists?   │
                └────────────┬───────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
            Yes │                         │ No
                ▼                         ▼
    ┌───────────────────────┐   ┌────────────────────────┐
    │  Use Local Version    │   │  Download Required     │
    │  - From bin/          │   │  1. Check cache        │
    │  - From bin/archived/ │   │  2. Fetch from         │
    │                       │   │     modules-untouched  │
    │                       │   │  3. Extract archive    │
    │                       │   │  4. Find mailpit.exe   │
    └───────────┬───────────┘   └─────────┬────────────��─┘
                │                         │
                └────────────┬────────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Prepare Bundle        │
                │  1. Create prep dir    │
                │  2. Copy mailpit files │
                │  3. Overlay            │
                │     bearsampp.conf     │
                └────────────┬───────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Create Build Copy     │
                │  bundles_build/        │
                │  (uncompressed)        │
                └────────────┬───────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Create Archive        │
                │  1. Determine format   │
                │  2. Compress (7z/zip)  │
                │  3. Output to:         │
                │     {buildPath}/       │
                │     {bundleType}/      │
                │     {bundleName}/      │
                │     {bundleRelease}/   │
                └────────────┬───────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Generate Hash Files   │
                │  - MD5                 │
                │  - SHA1                │
                │  - SHA256              │
                │  - SHA512              │
                └────────────┬───────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  Build Complete!       │
                │  Archive + Hashes      │
                └────────────────────────┘
```

## Detailed Steps

### 1. Version Selection

#### Interactive Mode
```bash
gradle release
```

**Process:**
1. Scans `bin/` directory for versions
2. Scans `bin/archived/` directory for versions
3. Displays numbered menu with all versions
4. Waits for user input
5. Validates input (index or version string)
6. Proceeds with selected version

**Example:**
```
Available mailpit versions:
======================================================================
   1. 1.18.7          [bin/archived]
   2. 1.20.3          [bin/archived]
   ...
  21. 1.27.10         [bin]

Enter version to build (index or version string):
> 21
```

#### Non-Interactive Mode
```bash
gradle release "-PbundleVersion=1.27.10"
```

**Process:**
1. Reads `bundleVersion` property
2. Validates version exists
3. Proceeds with specified version

### 2. Source Resolution

**Priority Order:**
1. **Local bin/** - `D:/Bearsampp-dev/module-mailpit/bin/mailpit{version}/`
2. **Local bin/archived/** - `D:/Bearsampp-dev/module-mailpit/bin/archived/mailpit{version}/`
3. **Download from modules-untouched** - If mailpit.exe not found locally

**Download Process:**
```
1. Check cache: bearsampp-build/tmp/downloads/mailpit/
2. If not cached:
   a. Fetch mailpit.properties from modules-untouched
   b. Get download URL for version
   c. Download archive
   d. Cache in downloads/
3. Extract to: bearsampp-build/tmp/extract/mailpit/{version}/
4. Find mailpit.exe in extracted files
5. Return path to mailpit directory
```

### 3. Bundle Preparation

**Location:** `bearsampp-build/tmp/bundles_prep/bins/mailpit/mailpit{version}/`

**Steps:**
1. Create prep directory
2. Copy mailpit binaries from source
3. Overlay bearsampp.conf from `bin/mailpit{version}/bearsampp.conf` (if exists)

**Files Copied:**
```
mailpit{version}/
├── mailpit.exe
├── LICENSE
├── README.md
└── bearsampp.conf  (overlayed from bin/)
```

### 4. Build Copy Creation

**Location:** `bearsampp-build/tmp/bundles_build/bins/mailpit/mailpit{version}/`

**Purpose:** Uncompressed version for development/testing

**Process:**
1. Create build directory
2. Copy all files from prep directory
3. This version can be used directly without extraction

### 5. Archive Creation

**Output Location:** `bearsampp-build/bins/mailpit/{bundleRelease}/`

**Filename Format:** `bearsampp-mailpit-{version}-{bundleRelease}.{format}`

**Example:** `bearsampp-mailpit-1.27.10-2025.10.14.7z`

**Compression:**
- **7z format**: Uses 7-Zip with `-mx9` (maximum compression)
- **zip format**: Uses Gradle's built-in zip task

**7-Zip Command:**
```bash
7z.exe a -t7z -mx9 {archiveFile} {prepPath}/*
```

### 6. Hash File Generation

**Generated Files:**
- `{archive}.md5` - MD5 checksum
- `{archive}.sha1` - SHA1 checksum
- `{archive}.sha256` - SHA256 checksum
- `{archive}.sha512` - SHA512 checksum

**Format:**
```
{hash} {filename}
```

**Example:**
```
a1b2c3d4e5f6... bearsampp-mailpit-1.27.10-2025.10.14.7z
```

## Directory Structure

### Input Directories

```
module-mailpit/
├── bin/
│   ├── mailpit1.27.0/
│   │   └── bearsampp.conf
│   ├── mailpit1.27.5/
│   │   └── bearsampp.conf
│   ├── mailpit1.27.9/
│   │   └── bearsampp.conf
│   ├── mailpit1.27.10/
│   │   └── bearsampp.conf
│   └── archived/
│       ├── mailpit1.18.7/
│       │   └── bearsampp.conf
│       ├── mailpit1.20.3/
│       │   └── bearsampp.conf
│       └── ...
└── build.gradle
```

### Output Directories

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
    │           └── mailpit1.27.10/
    │               ├── mailpit.exe
    │               ├── LICENSE
    │               ├── README.md
    │               └── bearsampp.conf
    ├── bundles_prep/
    │   └── bins/
    │       └── mailpit/
    │           └── mailpit1.27.10/
    │               ├── mailpit.exe
    │               ├── LICENSE
    │               ├── README.md
    │               └── bearsampp.conf
    ├── downloads/
    │   └── mailpit/
    │       ├── mailpit-windows-amd64.zip
    │       └── mailpit-untouched.properties
    └── extract/
        └── mailpit/
            └── 1.27.10/
                ├── mailpit.exe
                ├── LICENSE
                └── README.md
```

## Build Modes

### 1. Interactive Build
```bash
gradle release
```
- Shows version menu
- Waits for user input
- Best for manual builds

### 2. Non-Interactive Build
```bash
gradle release "-PbundleVersion=1.27.10"
```
- No user interaction
- Perfect for CI/CD
- Fails fast if version not found

### 3. Batch Build
```bash
gradle releaseAll
```
- Builds all versions in bin/ and bin/archived/
- Shows progress for each version
- Continues on errors, reports at end

## Caching Strategy

### Download Cache
**Location:** `bearsampp-build/tmp/downloads/mailpit/`

**Behavior:**
- Downloads are cached permanently
- Subsequent builds reuse cached files
- Saves bandwidth and time

**Example:**
```
First build:  Downloads (30s) + Extract (5s) + Build (5s) = 40s
Second build: Cache (0s) + Extract (5s) + Build (5s) = 10s
```

### Extract Cache
**Location:** `bearsampp-build/tmp/extract/mailpit/{version}/`

**Behavior:**
- Extracted files are cached per version
- Reused if mailpit.exe not found in bin/
- Cleared by `gradle clean` (optional)

## Error Handling

### Version Not Found
```
Bundle version not found: 1.99.99

Searched in:
  - D:\Bearsampp-dev\module-mailpit\bin\mailpit1.99.99
  - D:\Bearsampp-dev\module-mailpit\bin\archived\mailpit1.99.99

Available versions:
  - 1.18.7
  - 1.20.3
  ...
```

### Download Failed
```
Failed to download from modules-untouched: Connection timeout

Tried URL: https://github.com/Bearsampp/modules-untouched/...

Please verify:
1. Version 1.27.10 exists in modules-untouched repository
2. The URL is correct in mailpit.properties
3. You have internet connectivity
```

### 7-Zip Not Found
```
7-Zip executable not found!

Please install 7-Zip or set 7Z_HOME environment variable.
Download from: https://www.7-zip.org/
```

## Performance Optimization

### Parallel Builds
Gradle automatically parallelizes:
- File copying
- Hash generation
- Multiple version builds (releaseAll)

### Incremental Builds
- Cached downloads
- Cached extractions
- Gradle's up-to-date checking

### Build Times
| Operation | First Build | Cached Build |
|-----------|-------------|--------------|
| Download | 20-30s | 0s (cached) |
| Extract | 5s | 0s (cached) |
| Prepare | 2s | 2s |
| Compress | 3s | 3s |
| Hash | 1s | 1s |
| **Total** | **31-41s** | **6s** |

## Configuration

### build.properties
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z
build.path = D:/Bearsampp-build  # Optional
```

### Environment Variables
```bash
BEARSAMPP_BUILD_PATH=D:/CustomPath
7Z_HOME=C:/Program Files/7-Zip
```

### Priority Order
1. Command-line properties (`-Pbuild.path=...`)
2. build.properties
3. Environment variables
4. Defaults

## Integration with modules-untouched

### Repository Structure
```
modules-untouched/
├── modules/
│   └── mailpit.properties
└── releases/
    └── mailpit-2025.10.14/
        └── mailpit-windows-amd64.zip
```

### mailpit.properties Format
```properties
1.18.7=https://github.com/Bearsampp/modules-untouched/releases/download/mailpit-2025.10.14/mailpit-windows-amd64.zip
1.20.3=https://github.com/Bearsampp/modules-untouched/releases/download/mailpit-2025.10.14/mailpit-windows-amd64.zip
...
```

### Fallback URL Construction
If version not in mailpit.properties:
```
https://github.com/Bearsampp/modules-untouched/releases/download/mailpit-{version}/mailpit-{version}-windows-amd64.zip
```

## Comparison with Ant Build

| Feature | Ant Build | Gradle Build |
|---------|-----------|--------------|
| Interactive Mode | ❌ No | ✅ Yes |
| Auto-Download | ❌ No | ✅ Yes |
| Caching | ❌ No | ✅ Yes |
| Hash Generation | ✅ Yes | ✅ Yes |
| Batch Building | ❌ No | ✅ Yes |
| Parallel Builds | ❌ No | ✅ Yes |
| Pure Gradle | ❌ No | ✅ Yes |
| modules-untouched | ❌ No | ✅ Yes |

## Summary

The Gradle build system provides:
- ✅ **Simplicity** - Single command builds
- ✅ **Flexibility** - Interactive or non-interactive
- ✅ **Automation** - Auto-download and caching
- ✅ **Reliability** - Error handling and validation
- ✅ **Performance** - Caching and parallelization
- ✅ **Completeness** - Hash files and verification

For more information, see:
- [QUICK_START.md](QUICK_START.md) - Quick start guide
- [README.md](README.md) - Complete documentation
- [MIGRATION_NOTES.md](MIGRATION_NOTES.md) - Migration from Ant
