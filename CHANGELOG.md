# Changelog

All notable changes to Appine are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2026-11-18

### Added

- **Signed release APK from CI.** `android.yml` can build `assembleRelease` on demand with `build=release`. The PKCS#12 keystore is restored from Actions secrets into a runner-temp file and removed after the build; local builds keep using the debug key.
- **R8 mapping shipped with the APK.** The release artifact includes `mapping/release/mapping.txt` beside `app-release.apk` so stack traces can be decoded.
- **Release notes workflow.** `CHANGELOG.md` is the single source for release descriptions, following the Keep a Changelog format used by KZKT, and `AGENTS.md` records the procedure for building and publishing later versions.

### Changed

- **Commit and release policy documented.** Significant changes are committed and pushed with a matching `CHANGELOG.md` update, and git author identity stays in local repository configuration only — never in tracked files, code, or release notes.
