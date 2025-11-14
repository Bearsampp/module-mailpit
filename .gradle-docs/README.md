# Gradle Build Documentation

Welcome to the Gradle build documentation for module-mailpit!

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
gradle releaseBuild
```

The build will:
1. Show available versions from `releases.properties`, `bin/`, and `bin/archived/`
2. Let you select a version interactively
3. Use local version if available, or download from remote
4. Prepare the bundle
5. Create the release archive

## 🎯 Key Features

- ✅ Interactive version selection
- ✅ Checks `bin/` directory for local versions
- ✅ Checks `bin/archived/` directory for archived versions
- ✅ Falls back to releases.properties
- ✅ Falls back to modules-untouched repository
- ✅ Automatic download and extraction
- ✅ Bruno's build methods

## 📖 Where to Start

1. **New user?** → Start with [QUICK_START.md](QUICK_START.md)
2. **Need details?** → Read [GRADLE_INDEX.md](GRADLE_INDEX.md)
3. **Migrating from Ant?** → See [MIGRATION_NOTES.md](MIGRATION_NOTES.md)
4. **Want to understand the flow?** → Check [BUILD_FLOW.md](BUILD_FLOW.md)

## 💡 Example Session

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
> 19

Selected version: 1.27.10
Using local version from: bin/mailpit1.27.10
Using local version, skipping download
Preparing bundle...
Creating release archive...

============================================================
Release created successfully!
Archive: C:/Bearsampp-build/release/bearsampp-mailpit-1.27.10-2025.10.14.7z
Size: 12.34 MB
============================================================
```

## 🔧 Configuration

Edit `build.properties`:
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z
build.path = C:/Bearsampp-build  # Optional
```

## 📞 Support

- Full documentation: See files in this directory
- Issues: https://github.com/bearsampp/bearsampp/issues

---

**Happy Building!** 🚀
