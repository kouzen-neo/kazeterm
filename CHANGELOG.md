# Changelog

All notable changes to Appine are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2026-11-18

### Added

- **Signed release APK from CI.** `release.yml` builds and signs the arm64-v8a APK with a PKCS#12 keystore restored from Actions secrets into a runner-temp file, then removes it. `android.yml` can also build a signed release on demand for testing.
- **Versioned release files.** The published APK is named `Appine-arm64-v8a-vX.Y.Z.apk`, and its R8 mapping and `sha256sums.txt` are attached to the same GitHub Release. The version passed to the trigger overrides the Gradle defaults.
- **Automatic release notes.** `scripts/release-notes` extracts the matching `CHANGELOG.md` section and the release job turns it into the GitHub Release body, with the APK checksum, a download line and a link to the full changelog.

### Changed

- **Commit and release policy documented.** Significant changes are committed and pushed with a matching `CHANGELOG.md` update, and git author identity stays in local repository configuration only — never in tracked files, code, or release notes.
- **Agent instructions mirror the release workflow.** `AGENTS.md` now requires English across all repository content and records the licence/notices line, the post-release verification and stale-tag cleanup needed to reproduce a release.
