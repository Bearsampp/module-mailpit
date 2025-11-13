# Ant to Gradle Migration Notes

## Overview

This document describes the migration from Ant to Gradle for the module-mailpit build system, following Bruno's build methods.

## Key Improvements

### 1. Interactive Build Process
**Ant**: Required manual editing of properties or command-line parameters
**Gradle**: Interactive menu-driven version selection

### 2. Automatic Fallback
**Ant**: Only used local releases.properties
**Gradle**: Automatically falls back to https://github.com/Bearsampp/modules-untouched/blob/main/modules/mailpit.properties

### 3. Integrated Build Logic
**Ant**: Required external build-commons.xml and build-bundle.xml from dev project
**Gradle**: All logic integrated in build.gradle (still verifies dev project exists for compatibility)

### 4. Better Error Handling
**Gradle**: Clear error messages and validation at each step

## Build Process Comparison

### Ant Build Process
```xml
<target name="release.build">
    <basename property="bundle.folder" file="${bundle.path}"/>
    <replaceproperty src="bundle.folder" dest="bundle.version" replace="${bundle.name}" with=""/>
    <getmoduleuntouched name="${bundle.name}" version="${bundle.version}" propSrcDest="bundle.srcdest" propSrcFilename="bundle.srcfilename"/>
    <assertfile file="${bundle.srcdest}/mailpit.exe"/>
    <delete dir="${bundle.tmp.prep.path}/${bundle.folder}"/>
    <mkdir dir="${bundle.tmp.prep.path}/${bundle.folder}"/>
    <copy todir="${bundle.tmp.prep.path}/${bundle.folder}">
        <fileset dir="${bundle.srcdest}" excludes="doc/**"/>
    </copy>
    <copy todir="${bundle.tmp.prep.path}/${bundle.folder}" overwrite="true">
        <fileset dir="${bundle.path}" defaultexcludes="yes"/>
    </copy>
</target>
```

### Gradle Build Process
```gradle
task releaseBuild {
    dependsOn verifyDevProject, createRelease
}

// Interactive version selection
task selectVersion { ... }

// Download from releases.properties or modules-untouched
task downloadModule(dependsOn: selectVersion) { ... }

// Prepare bundle (same logic as Ant)
task prepareBundle(dependsOn: downloadModule) { ... }

// Create release archive
task createRelease(dependsOn: prepareBundle) { ... }
```

## Configuration Files

### build.properties (Unchanged)
```properties
bundle.name = mailpit
bundle.release = 2025.10.14
bundle.type = bins
bundle.format = 7z
```

### releases.properties (Unchanged)
Contains version-to-URL mappings for released versions.

### New: settings.gradle
```gradle
rootProject.name = 'module-mailpit'
```

### New: build.gradle
Main build script with all build logic.

## Task Mapping

| Ant Target | Gradle Task | Description |
|------------|-------------|-------------|
| release.build | releaseBuild | Main build task |
| (manual) | selectVersion | Interactive version selection |
| (from build-commons) | downloadModule | Download and extract |
| release.build (partial) | prepareBundle | Prepare bundle directory |
| (from build-bundle) | createRelease | Create release archive |
| clean | cleanBuild | Clean temporary files |

## File Structure

```
module-mailpit/
├── build.gradle              # Main build script (NEW)
├── settings.gradle           # Gradle settings (NEW)
├── gradlew.bat              # Gradle wrapper for Windows (NEW)
├── build-release.bat        # Convenience script (NEW)
├── BUILD_GRADLE.md          # Gradle build documentation (NEW)
├── MIGRATION_NOTES.md       # This file (NEW)
├── build.xml                # Original Ant build (KEPT for compatibility)
├── build.properties         # Build configuration (UNCHANGED)
├── releases.properties      # Version mappings (UNCHANGED)
└── bin/                     # Module binaries (UNCHANGED)
```

## Running Builds

### Ant (Original)
```bash
ant release.build
```
Requires:
- Manual version setup in bin/ directory
- dev project with build-commons.xml and build-bundle.xml
- Manual property configuration

### Gradle (New)
```bash
gradle releaseBuild
# or
./gradlew releaseBuild
# or
build-release.bat
```
Features:
- Interactive version selection
- Automatic download
- Automatic fallback to modules-untouched
- Clear progress messages

## Version Resolution Logic

### Gradle Implementation
```gradle
1. User selects version interactively
2. Check releases.properties for URL
3. If not found:
   a. Fetch https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/mailpit.properties
   b. Look up version in fetched properties
   c. Use URL from modules-untouched
4. Download and extract
5. Verify mailpit.exe exists
6. Prepare bundle
7. Create release archive
```

## Bruno's Build Methods

The Gradle build follows Bruno's established patterns:

1. **Property-based Configuration**: Uses build.properties for core settings
2. **Version Management**: Leverages releases.properties as primary source
3. **Fallback Strategy**: Implements modules-untouched as fallback
4. **Bundle Structure**: Maintains exact same bundle preparation logic
5. **Archive Format**: Supports 7z and zip formats
6. **Path Conventions**: Uses standard Bearsampp build paths
7. **Verification**: Validates dev project and required files

## Benefits of Gradle

1. **Modern Build Tool**: Better dependency management and plugin ecosystem
2. **Incremental Builds**: Only rebuilds what changed
3. **Better IDE Integration**: Native support in IntelliJ, Eclipse, VS Code
4. **Groovy/Kotlin DSL**: More powerful than XML
5. **Task Dependencies**: Clear, declarative task relationships
6. **Interactive**: User-friendly prompts and menus
7. **Extensible**: Easy to add new tasks and functionality

## Backward Compatibility

- Original Ant build (build.xml) is kept for compatibility
- Both build systems can coexist
- Output format is identical
- Same directory structure
- Same configuration files

## Testing the Migration

1. **Test Interactive Build**:
   ```bash
   gradle releaseBuild
   ```
   Select a version from the menu

2. **Test Custom Version**:
   ```bash
   gradle releaseBuild
   ```
   Type 'custom' and enter a version

3. **Test Fallback**:
   ```bash
   gradle releaseBuild
   ```
   Enter a version not in releases.properties

4. **Verify Output**:
   Check `C:/Bearsampp-build/release/` for the archive

5. **Compare with Ant**:
   Build the same version with Ant and compare archives

## Future Enhancements

Possible improvements for the Gradle build:

1. **Parallel Downloads**: Download multiple versions simultaneously
2. **Caching**: Cache downloaded archives to avoid re-downloading
3. **Validation**: Checksum verification for downloads
4. **Publishing**: Direct publishing to GitHub releases
5. **Testing**: Automated testing of built modules
6. **Documentation**: Auto-generate documentation from build

## Support

For issues or questions:
- Check BUILD_GRADLE.md for usage instructions
- Review this migration guide for differences
- Compare with original Ant build if needed
- Report issues to Bearsampp repository

## Conclusion

The Gradle migration maintains 100% compatibility with the Ant build while adding:
- Interactive user experience
- Automatic fallback to modules-untouched
- Better error handling
- Modern build tool features
- Easier maintenance and extension

Both build systems can be used interchangeably during the transition period.
