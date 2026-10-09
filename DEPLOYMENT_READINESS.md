# First deployment: prepared, not yet runtime-verified

No remote operation, push or deployment was performed. No original application, web template, asset or question-bank file was changed. Only `.github/workflows/deploy-pages.yml` and `.gitignore` were edited; preparation files were added.

## Actual application and hosting configuration

This is a Flutter/Dart application (`lib/main.dart`, `pubspec.yaml`, `web/index.html`), not a Node website. The web build is `flutter build web --release --base-href <verified-path>`. Flutter packages include `shared_preferences` and `cupertino_icons`. The existing Pages workflow uploads only `build/web` using `upload-pages-artifact`, then publishes it with `deploy-pages`.

The former workflow automatically published every `main` push, tracked a moving stable SDK, and hardcoded `/trivia-game/`. It is now manual-only, defaults to a preview build, requires a numeric exact Flutter version and dependency lockfile, and requires a rollback reference when publishing. The deploy job alone receives Pages write permissions. Deployments are serialized rather than interrupted. A separate downloadable `preview-web-<commit SHA>-<run ID>-<attempt>` artifact is retained for 90 days; download and archive it permanently for each release.

This folder has no Git metadata, verified owner/repository URL, current Pages settings, old production artifact or installed Flutter/Dart. `/trivia-game/` is an existing configuration value, not a verified URL. For a project site use `/ACTUAL-REPOSITORY-NAME/`; for a root/custom-domain site normally use `/`. Confirm the real site first. GitHub environment protection must be configured in repository settings; YAML alone does not create a reviewer approval requirement.

## Backups and complete replacement

`deployment-preparation/source-before.zip` contains the pre-edit local source tree, including completed banks and the previous workflow. Its contents are verified individually against `source-before.json`. SHA-256: `BB7FDE5E0D3DFD36C09F136F03AAE00F75ED74115DE3E6270A8C1E873EC0C5E9`. Copy both files outside this project before publishing. This backup preserves local work; it is NOT a backup of the currently published website.

Before any release, record the old site URL, publishing mode, last successful deployment run and commit SHA. Download the old complete deployment artifact from that run, verify it contains the old HTML, bootstrap, JavaScript, assets and any service worker, and archive it with a SHA-256 checksum. Pages artifacts may be wrapped in `artifact.tar`; preserve that full archive. If branch publishing was used, archive the entire publishing branch at its current commit. Also keep the old source, SDK version and dependency lock. Store backups outside the published directory. If no complete old artifact/branch exists, rebuild the recorded old commit in a separate clean checkout with its original SDK and lock, then verify that output before proceeding. Do not treat a saved home page or the new local source ZIP as a complete rollback backup.

Every new CI build starts in a fresh hosted-runner checkout and publishes one complete `build/web` artifact. Do not copy new files over an old `docs`, `gh-pages`, server folder or previous build. Do not upload repository source, backup ZIPs or audit files as website content. This artifact approach avoids retaining obsolete old server files. Existing open browser tabs and caches can still retain an old client; test upgrade behavior separately. Preserve and verify Flutter's generated legacy-service-worker cleanup behavior for the chosen SDK. Do not inject broad cache/storage deletion or clear `shared_preferences` data.

## Checks available here

Run from the project root with PowerShell 7 and Node:

```powershell
pwsh -NoProfile -File tool/final_next_batch_audit.ps1
pwsh -NoProfile -File tool/deployment_preflight.ps1
```

The first checks 23 certified categories (4,692 questions), bank distributions, recorded source/translation/editorial checks, exact duplicates, reviewed semantic/cross-bank candidates and 667 protected hashes. It does not certify all 50 catalog categories or re-fetch every source URL. The second checks all original files except the two intentional deployment edits, all 136 required clue images, the manifest JSON, PowerShell/JavaScript tool syntax and every local backup entry hash. Run validators without report-writing/save switches to preserve protected artifacts.

Flutter/Dart analysis, Dart regressions, runtime bank validation, release compilation, browser smoke tests and compiled asset checks cannot run here. The source catalog has 50 categories; the playable registry also includes legacy categories outside the 23 certified banks. The unscoped Dart validator checks all 50; any failure must be investigated rather than weakening the publishing gate. No test results or quality certification for those additional categories are implied.

## Exact next steps (after review and authorization)

1. Copy the local backup and inventory to independent storage. Obtain and verify the old published output backup as above; record its location and old commit SHA. Test serving that backup so rollback is concrete.
2. Work in a genuine clone of the correct GitHub repository. Before updating `main`, disable any old automatic publishing workflow and inspect Settings → Pages. Confirm the domain/path, Actions permissions and any other workflow that could publish. Preserve old deployment backups before changing publishing settings. Review these prepared changes in that clone; preserve banks exactly. Do not blindly replace a newer remote checkout with this extracted folder.
3. Install/select one exact supported Flutter stable version locally and record `flutter --version`. Run `flutter pub get` to generate the missing `pubspec.lock`; review it and commit it with the deployment preparation. `.gitignore` now permits that lockfile. Do not manually invent a lockfile. Use that same SDK version in Actions.
4. Run the two static commands above in this original checkout. In the clone, remap the absolute paths in preservation-check tooling to that checkout for checking only, without rewriting protected banks/manifests; or compare each protected file by its repository-relative path and recorded SHA-256. Existing bank scripts contain machine-specific paths, so they are not yet portable CI checks.
5. Run the following SDK checks in the genuine clone; resolve and review every failure before publication. The existing test files are standalone Dart programs, not `flutter_test` suites:

   ```powershell
   flutter pub get --enforce-lockfile
   flutter analyze
   dart run test/question_history_test.dart
   dart run test/question_bank_validation_test.dart
   dart run tool/validate_question_bank.dart
   # In a fresh checkout, substitute the verified base path:
   flutter build web --release --base-href /trivia-game/
   ```

6. When explicitly authorized to push, commit/push the reviewed preparation and lockfile. Select GitHub Actions as the Pages publishing source and configure required reviewers on the `github-pages` environment where supported. In Actions manually run this workflow with the exact tested SDK, verified base path and **publish=false**. This builds and uploads artifacts without running the deploy job.
7. Download the preview artifact. Serve it over HTTP mounted at the actual base path (not `file://`). Check both languages, category selection, 200/200/400/400/600/600 selection, questions/answers, scoring, timers, navigation, persistent history and both picture clues. Test mobile layout and a browser profile previously used for the old site, including legacy service-worker/cache upgrade behavior. Check browser network errors and that all 136 clues are present in `assets/assets/two_pics/`. Keep the verified artifact and checksum outside GitHub's retention window.
8. Only after approval, run the workflow against the same reviewed commit and exact SDK/base path with **publish=true** and the verified old backup location plus commit SHA in **backup_reference**. Approve the protected environment. This publishes a fresh complete artifact, without copying into old output or manually deleting remote files. Check the returned Pages URL in fresh and previously used profiles.
9. If smoke checks fail, pause further releases and restore the verified OLD OUTPUT through a manual Pages artifact workflow: unpack the old artifact into an empty directory, upload that directory with `upload-pages-artifact`, and deploy with `deploy-pages` under the same environment approval. Restore any domain configuration separately if changed. Do not merge old/new directories, reset protected banks, or assume rerunning an old workflow with floating dependencies reproduces the old site.

Official references: [GitHub custom Pages workflows](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages), [Pages publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site), [Flutter web cache and service workers](https://docs.flutter.dev/platform-integration/web/faq).
