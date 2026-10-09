# Publication status — awaiting missing image assets

The user authorized replacing the existing Pages website with a clean build while preserving Git history and the new game. No push or deployment has occurred. The repository and URL remain `DEVWEAR/trivia-game` and `https://devwear.github.io/trivia-game/`.

## Completed fixes and checks

- Removed only the unused `_stars` source constant from the unprotected legacy Space file. No question or answer changed. Flutter analysis reports **No issues found**.
- Added Flutter test support and refreshed the generated dependency lockfile using verified Flutter 3.47.6 / Dart 3.13.5.
- Existing standalone Dart history and bank-validator regression programs pass.
- Five new smoke tests pass: all 136 supplied images decode; every visible category provides 200/200/400/400/600/600; Arabic and English category selection/reveal/scoring; 60-second timeout transfers to the other team for 15 seconds.
- All 23 certified categories pass runtime validation: 4,692 questions, 204 and 68/68/68 each. The complete static/editorial audit was rerun and passed. All 667 protected original entries remain unchanged.
- A fresh web release build passes at `/trivia-game/`. Flutter's generated service-worker stub unregisters legacy workers. UI/gameplay implementation files have not been edited during the publication fixes.
- Added a portable 667-entry hash gate and Git attributes preserving source bytes across Windows/Linux.
- The release validator checks every visible category's IDs, bilingual fields, six-slot capacity and local media, plus the strict 23 certified-bank requirements. The 50-category roadmap diagnostic remains available; empty planned/non-visible banks are not treated as completed production banks.
- The deployment workflow uses exact Flutter 3.47.6, enforces the lockfile, analyzes, runs tests and the release validator, verifies protected hashes, builds on a fresh runner, and uploads only `build/web` as a complete Pages artifact. Deployment cannot run if those checks fail. It stamps the deployed commit in `release.json`. No old-site backup is required.

## Actual remaining blocker

The pre-existing hard Two Pics bank has 34 cards (`two_pics_069` through `two_pics_102`), referencing **68 absent files** under `two_pics/069_1.jpg` through `two_pics/102_2.jpg`. The release validator fails on these exact missing files. The existing 136 easy/medium images are present, unchanged and decoded successfully; they do not supply those hard cards.

An image-content decision was requested: add matching original images to the existing hard cards while preserving question/answer text and game behavior, or keep publishing paused for image review. No placeholder images, reused unrelated pictures, weakened media checks, or removed categories have been used to bypass the blocker.

After the assets are resolved: register their exact legacy asset paths in Flutter, decode/check all required images, rerun required analysis/tests/release validation and clean build, verify hashes, recheck remote HEAD, make a normal append-only commit and push, watch GitHub build/deployment, then verify the live `release.json`, bootstrap/JavaScript/image delivery and game rendering. GitHub authorization will be requested if needed. No force-push or history rewrite is planned.

Raw results: `deployment-preparation/flutter-analyze.log`, `flutter-gameplay-smoke-test.log`, `dart-certified-catalog-validation.log`, `dart-release-validation.log`, `flutter-web-release.log`, and `publication-library-audit.log`.
