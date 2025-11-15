# Build Flow Diagram

## Gradle Build Process

```
┌─────────────────────────────────────────────────────────────────┐
│                     gradle releaseBuild                         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    verifyDevProject                             │
│  • Check if ../dev directory exists                             │
│  • Fail if not found                                            │
│  • Log success message                                          │
└───────────────���─────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     selectVersion                               │
│  • Load releases.properties                                     │
│  • Display version menu                                         │
│  • Prompt user for selection                                    │
│  • Accept: number, version, or 'custom'                         │
│  • Store selected version                                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    downloadModule                               │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 1. Check releases.properties for version                  │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 2. If not found:                                          │  │
│  │    • Fetch modules-untouched/mailpit.properties           │  │
│  │    • Look up version                                      │  │
│  │    • Use URL from modules-untouched                       │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 3. Download archive                                       │  │
│  │    • Create temp directory                                │  │
│  │    • Download file                                        │  │
│  │    • Show progress                                        │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 4. Extract archive                                        │  │
│  │    • Detect format (.7z or .zip)                          │  │
│  │    • Extract to temp directory                            │  │
│  │    • Find mailpit.exe                                     │  │
│  │    • Validate existence                                   │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    prepareBundle                                │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 1. Verify mailpit.exe exists                              │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 2. Create prep directory                                  │  │
│  │    • Delete if exists                                     │  │
│  │    • Create fresh directory                               │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 3. Copy from extracted source                             │  │
│  │    • Copy all files                                       │  │
│  │    • EXCLUDE: doc/**                                      │  │
│  └────────────────────────���─────────────────────────────────┘
│                              │                                  
│                              ▼                                  
│  ┌───────────────────────────────────────────────────────────┐ │
│  │ 4. Overlay from bin/{version}/                            │ │
│  │    • Copy module-specific files                           │ │
│  │    • Overwrite if exists                                  │ │
│  │    • Skip if directory doesn't exist                      │ │
│  └───────────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    createRelease                                │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 1. Create release directory                               │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 2. Generate archive name                                  │  │
│  │    bearsampp-{name}-{version}-{release}.{format}          │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 3. Create archive                                         │  │
│  │    • Use 7z for .7z format                                │  │
│  │    • Use zip for .zip format                              │  │
│  │    • Maximum compression                                  │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │ 4. Display success message                                │  │
│  │    • Archive path                                         │  │
│  │    • File size                                            │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                         ✅ COMPLETE
```

## Version Resolution Flow

```
User Input: "1.27.10"
        │
        ▼
┌───────────────────────────┐
│ Check releases.properties │
└───────────────────────────┘
        │
        ├─── Found? ────────────────────┐
        │                               │
        ▼                               ▼
    ✅ YES                          ❌ NO
        │                               │
        │                               ▼
        │                   ┌──────────────────────────┐
        │                   │ Fetch modules-untouched  │
        │                   │ mailpit.properties       │
        │                   └─────────���────────────┘
        │                               │
        │                               ├─── Found? ───┐
        │                               │              │
        │                               ▼              ▼
        │                           ✅ YES         ❌ NO
        │                               │              │
        │                               │              ▼
        │                               │         ❌ ERROR
        │                               │
        └───────────────┬───────────────┘
                        │
                        ▼
                  Download URL
                        │
                        ▼
                   Download File
                        │
                        ▼
                  Extract Archive
                        │
                        ▼
                 Validate mailpit.exe
                        │
                        ▼
                   ✅ SUCCESS
```

## File Flow

```
Source Files                    Destination
─────────────                   ───────────

Downloaded Archive
    │
    ├── mailpit.exe ────────────────────┐
    ├── LICENSE ────────────────────────┤
    ├── README.md ──────────────────────┤
    ├── doc/ ───────────────────────────┤ EXCLUDE
    └── ... ────────────────────────────┤
                                        │
                                        ▼
                            {tmp}/prep/{version}/
                                        │
                                        │
bin/{version}/                          │
    │                                   │
    ├── bearsampp.conf ─────────────────┤ OVERLAY
    ├── mailpit.exe ────────────────────┤ (overwrite)
    └── ... ────────────────────────────┤
                                        │
                                        ▼
                            {tmp}/prep/{version}/
                                        │
                                        │ Archive
                                        ��
                    {build}/release/bearsampp-mailpit-{version}-{release}.7z
```

## Directory Structure

```
module-mailpit/
│
├── build.gradle              ← Main build script
├── settings.gradle           ← Gradle settings
├── build.properties          ← Configuration
├── releases.properties       ← Version mappings
│
├── bin/
│   ├── mailpit1.27.9/       ← Module overlay files
│   └── mailpit1.27.10/      ← Module overlay files
│
└── {build.path}/            ← Build output (default: C:/Bearsampp-build)
    ├── tmp/
    │   ├── download/        ← Downloaded archives
    │   ├── extract/         ← Extracted files
    │   └── prep/            ← Prepared bundles
    │       └── mailpit1.27.10/
    │           ├── mailpit.exe
    │           ├── bearsampp.conf
    │           └── ...
    │
    └── release/             ← Final archives
        └── bearsampp-mailpit-1.27.10-2025.10.14.7z
```

## Task Dependencies

```
releaseBuild (default task)
    │
    ├── verifyDevProject
    │
    └── createRelease
            │
            └── prepareBundle
                    │
                    └── downloadModule
                            │
                            └── selectVersion
```

## Error Handling Flow

```
Each Task
    │
    ├── Try
    │   └── Execute logic
    │       └── Success ──────────────────┐
    │                                     │
    └── Catch                             │
        └── Error                         │
            ├── Log error message         │
            ├── Provide context           │
            └── Throw GradleException     │
                                          │
                                          ▼
                                    Next Task
                                          │
                                          ▼
                                    Final Output
```

## User Interaction Flow

```
Start Build
    │
    ▼
Display Banner
    │
    ▼
Show Version Menu
    │
    ├─ 1. Version 1.18.7
    ├─ 2. Version 1.20.3
    ├─ ...
    └─ 19. Version 1.27.10
    │
    ▼
Prompt: "Enter version number..."
    │
    ├─── Input: "19" ──────────────┐
    ├─── Input: "1.27.10" ─────────┤
    └─── Input: "custom" ──────────┤
                                   │
                                   ▼
                          Resolve Version
                                   │
                                   ▼
                          Show Progress
                                   │
                          ├─ Downloading...
                          ├─ Extracting...
                          ├─ Preparing...
                          └─ Creating archive...
                                   │
                                   ▼
                          Show Success
                                   │
                          ├─ Archive: path
                          ├─ Size: XX MB
                          └─ Status: ✅
                                   │
                                   ▼
                                  Done
```

## Configuration Loading

```
build.gradle starts
    │
    ├── Load build.properties
    │   ├── bundle.name
    │   ├── bundle.release
    │   ├── bundle.type
    │   ├── bundle.format
    │   └── build.path (optional)
    │
    ├── Load releases.properties
    │   ├── 1.18.7 = URL
    │   ├── 1.20.3 = URL
    │   └── ...
    │
    ├── Check environment variables
    │   └── BEARSAMPP_BUILD_PATH
    │
    └── Calculate derived properties
        ├── rootDir = ../
        ├── devPath = ../dev
        ├── bundleTmpPath
        └── bundleTmpPrepPath
```

This visual representation helps understand the complete build flow from start to finish.
