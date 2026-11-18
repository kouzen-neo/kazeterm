# KazeTerm website

A minimal homepage in `dist/index.html` links to the English privacy policy in
`dist/privacy.html`. Both use inline CSS and a local SVG favicon with no JavaScript,
remote assets, dependencies or compilation step.

`dist/` contains the directly maintained website source and is committed to Git.
It is also the directory uploaded for deployment; no generation or copying is needed.

Open `dist/index.html` directly in a browser, or preview from the repository root:

```sh
python3 -m http.server 8000 --bind 127.0.0.1 --directory website/dist
```

Visit <http://127.0.0.1:8000> for the homepage or
<http://127.0.0.1:8000/privacy.html> for the policy. Edit `dist/privacy.html` to update
the policy and its effective date.

For static hosting, use `website/dist/` as the site root; no build step is needed.

For Cloudflare Pages Direct Upload, upload the `website/dist/` folder.

The current Direct Upload project is `kazeterm`, served at
<https://kazeterm.sh> and <https://kazeterm.pages.dev>. To update its production
deployment from the repository root using a logged-in Wrangler session:

```sh
npx wrangler pages deploy website/dist --project-name kazeterm --branch main
```

For Cloudflare Pages Git integration, set the root directory to `website`, the
framework preset to `None`, the output directory to `dist`, and the build command
to `exit 0`.

Cloudflare Pages redirects `/privacy.html` to `/privacy`; use
`https://kazeterm.sh/privacy` as the public policy URL.
See [Serving Pages](https://developers.cloudflare.com/pages/configuration/serving-pages/).

## Favicon

`dist/favicon.svg` is adapted from the Android launcher foreground vector and
`res/values/colors.xml`. It retains the white body, green outer stroke and clipping,
uses a transparent background, and fills the two facial cutouts with black.
A `26 25 56 56` viewBox removes the adaptive-icon
padding so the symbol remains legible at favicon sizes.

Maintain the SVG directly. When the Android icon changes, update the favicon as
needed and review its crop and appearance at small sizes. Deployment only copies
the SVG; it does not need Python or the Android source tree.

## Content maintenance

Keep the `email_off` comments around the public contact link. They prevent
Cloudflare from replacing the address with JavaScript-based email obfuscation.

The policy describes the current Android implementation. Recheck these sources
when behavior changes:

- `AndroidManifest.xml`, the merged release manifest and Gradle dependencies:
  permissions, including AndroidX biometric permissions, and included SDKs.
- `Rootfs.kt`: automatic mirror probes, download destinations and repository protocols.
- `Diagnostics.kt` and `Tabs.kt`: local data, exported diagnostics and retention.
- `Privacy.kt`, `Documents.kt`, `TerminalFiles.kt` and terminal clipboard handlers:
  authentication, grants, imports and clipboard access.
- `res/xml/data_extraction_rules.xml`: backup and transfer exclusions.

These paths are under `android/app/src/main/` unless they refer to build inputs or
generated output. Developer identity and the contact email were supplied by the
maintainer. The support-retention wording uses a purpose-based period: resolve the
request and related follow-up, then delete unless legal retention applies. Keep
actual support handling consistent with that policy.

## Google Play publication

Reviewed against the following official guidance on November 17, 2026:

- [User Data, including Privacy Policy requirements](https://support.google.com/googleplay/android-developer/answer/10144311?hl=en)
- [Data safety declarations](https://support.google.com/googleplay/android-developer/answer/10787469?hl=en)
- [Android biometric authentication](https://developer.android.com/identity/sign-in/biometric-auth)

Before submitting a release:

1. Publish this page at a stable public URL, accessible without sign-in or geographic
   restrictions, and enter that URL in Play Console. Visitors must not be able to edit it.
2. Verify that Settings → About → Privacy policy opens `https://kazeterm.sh/privacy`
   in the release build. Privacy mode is a separate feature.
3. Check the final release artifact and all SDK behavior against this policy and
   complete the Data safety form. Local processing, user-initiated sharing and
   automatic mirror requests have different declaration rules; do not infer
   "no collection" solely from the absence of a developer backend. Mirror hosts'
   log retention and IP-address use need review for those declarations.
4. Confirm support-mail handling and the policy dates for the release. Review any
   hosting-provider request logging when choosing the public host.

The current Debian repository configuration uses HTTP even though the built-in
mirror probes and image download use HTTPS. The policy discloses this; do not claim
universal transport encryption without reviewing the guest configuration.

Editing this page does not redeploy it, add the Android entry point, submit Play
Console declarations, or establish Google Play approval.
