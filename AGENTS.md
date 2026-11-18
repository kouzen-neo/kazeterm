# Agent Instructions

These instructions apply to the whole repository, regardless of the coding agent used.
See `README.md` for development commands and `android/README.md` for Android-specific setup.

## Language

- Write code comments, doc comments and developer-facing messages (assertions, panics, logs, script output) in English, using the terms of the module's map.
- `docs/rounds/` (frozen, see Records below) is in Chinese; user-facing Android strings are localized in `res/values*/strings.xml`.

## Knowledge Loop Conventions

Use the repository's `.agents/` paths for the module registry, maps, and decision summaries, even when a tool defaults to another directory.

### Before editing code

1. Resolve every module the change touches through `.agents/MODULES.md`; map `/` in an ID to subdirectories.
2. Read `.agents/maps/<module>.md` and `.agents/decisions/<module>.md` when present for every affected module. Do not load unrelated module files; if output is truncated, continue with focused ranges until each required file is complete.
3. Expand source context only to answer a named unresolved question. Stop when the behavior, change boundary, constraints, and verification path are clear.
4. Run `git log --oneline -10 -- <path>` for files about to change. Use `git show` only for recent commits relevant to the current behavior, including those with matching `MODULE: <current module>` Decision blocks.

### After finishing a task

- If implementation changes invalidate an existing module map, use the `map-module` skill: targeted refresh when the impact is bounded, otherwise full refresh. If unavailable, report the map as stale.
- In every Decision block created by the `commit-context` skill, fill `MODULE`, `WHY`, `ALTERNATIVES`, `CHOSEN`, `TRADEOFFS`, and `RISKS`; add `SUPERSEDES` when replacing a prior Decision.

### Records

- In the commit body, describe how the change was tested and include any relevant measurements or survey results. `docs/rounds/` is frozen after round 208: do not add rounds, index rows or "→" marks.
- Deferred work and problems found but not fixed go into the affected map's "Confirmed bugs / technical debt" or "Open questions", and are removed from it when done; pitfalls worth knowing later go into its "Invariants and gotchas".
- When a deferred item from an old round comes up again, check it against the current code. If it is still open, record it in its module's map.
- Cross-change reference (measurement conditions, R1 measurements, known flaky tests) stays in `docs/milestones.md`. Work with no diff (surveys, investigations) gets a short doc under `docs/` only when worth keeping.
- Historical records may name `/commit-context` or `/map-module`; these refer to the commit and map workflows described above. Pinned `git show <commit>:<path>` references retain the path that existed in that commit.

## Releasing a version

`CHANGELOG.md` is the single source for release notes: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format, Semantic Versioning, newest version first, with `### Added`, `### Changed`, `### Fixed` and a bold lead-in on each user-visible item.

For every release build (1.0.0, 1.0.1, 1.0.2, ...), in order:

1. Bump `versionName` and `versionCode` in `android/app/build.gradle.kts`, and add the matching `## [vX.Y.Z] - YYYY-MM-DD` section to `CHANGELOG.md`.
2. Dispatch the signed arm64-v8a build with `gh workflow run android.yml --ref master --repo <owner>/appine -f build=release`. The workflow restores the PKCS#12 keystore from `SIGNING_KEYSTORE_BASE64`, `SIGNING_KEYSTORE_PASSWORD`, `SIGNING_KEY_ALIAS` and `SIGNING_KEY_PASSWORD` into a runner-temp file, runs `assembleRelease lintDebug`, then deletes the key. Artifact `appine-release-apk` holds `app-release.apk` and `mapping/release/mapping.txt`.
3. Download the artifact, compute `sha256sum` of the APK, and publish `gh release create vX.Y.Z <apk> <mapping> <sha256sums.txt> --title "Appine vX.Y.Z"`.
4. Write the release body in the KZKT convention: `# Appine vX.Y.Z`, the version's `### Added`/`### Changed`/`### Fixed` items copied from `CHANGELOG.md`, then `---`, `## APK` with each file name and its sha256, a download line, `---`, and `*Full changelog: [CHANGELOG.md](.../blob/master/CHANGELOG.md)*`. For AGPL, state that the complete corresponding source is this public repository at the build commit.
5. Refresh `.agents/maps/android/build.md` and `.agents/maps/harness.md` when this flow changes. Never commit the keystore, its passwords, or the signing secrets to the repository.
