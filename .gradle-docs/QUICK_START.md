# Quick Start - Gradle Build

## TL;DR

```bash
# Interactive build (recommended)
gradle releaseBuild

# Or use the batch file
build-release.bat
```

## What Happens?

1. 📋 Shows you a list of available versions
2. ✅ You select a version (by number or name)
3. 📥 Downloads the version automatically
4. 📦 Prepares the bundle
5. 🗜️ Creates the release archive
6. ✨ Done!

## Example Session

```
=== Bearsampp Module Builder - mailpit ===
Available versions in releases.properties:
============================================================
1. 1.18.7
2. 1.20.3
3. 1.20.4
...
18. 1.27.9
19. 1.27.10

Enter version number (or type version directly, or 'custom' for unlisted version):
> 19

Selected version: 1.27.10

Download URL: https://github.com/Bearsampp/module-mailpit/releases/download/...
Downloading...
Extracting...
Preparing bundle...
Creating release archive...

============================================================
Release created successfully!
Archive: C:/Bearsampp-build/release/bearsampp-mailpit-1.27.10-2025.10.14.7z
Size: 12.34 MB
============================================================
```

## Version Not in List?

Type `custom` when prompted:

```
Enter version number (or type version directly, or 'custom' for unlisted version):
> custom

Enter custom version:
> 1.28.0
```

The build will automatically check:
1. ✅ releases.properties (local)
2. ✅ https://github.com/Bearsampp/modules-untouched (fallback)

## Requirements

- ☕ Java 8+
- 🔧 Gradle (or use system Gradle)
- 📦 7-Zip (for .7z archives)

## Output Location

```
C:/Bearsampp-build/release/bearsampp-mailpit-{version}-{release}.7z
```

## Clean Up

```bash
gradle cleanBuild
```

## Need Help?

- 📖 Full docs: [BUILD_GRADLE.md](BUILD_GRADLE.md)
- 🔄 Migration info: [MIGRATION_NOTES.md](MIGRATION_NOTES.md)
- 🐛 Issues: https://github.com/bearsampp/bearsampp/issues

## Pro Tips

💡 **Tip 1**: You can type the version directly instead of selecting by number
```
> 1.27.10
```

💡 **Tip 2**: Set custom build path in build.properties
```properties
build.path = D:/MyBuilds
```

💡 **Tip 3**: Use environment variable for build path
```bash
set BEARSAMPP_BUILD_PATH=D:/MyBuilds
gradle releaseBuild
```

💡 **Tip 4**: See all available tasks
```bash
gradle tasks
```

## Troubleshooting

❌ **"Project 'dev' not found"**
→ Make sure `../dev` directory exists

❌ **"Version not found"**
→ Check spelling, or use 'custom' option

❌ **"7z command not found"**
→ Install 7-Zip and add to PATH

❌ **"mailpit.exe not found"**
→ Archive structure may have changed, check extraction log

## That's It! 🎉

The Gradle build handles everything automatically. Just select a version and go!
