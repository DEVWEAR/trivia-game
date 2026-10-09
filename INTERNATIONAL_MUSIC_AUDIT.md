# International Music — COMPLETE

Validated 8 October 2026 with the existing question schema and point values.

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| International Music | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE |

Duplicate IDs, Arabic questions, English questions and fact keys: zero. Missing question/answer fields, wrong category IDs, invalid point mappings and invalid absolute HTTPS URL syntax: zero. All 204 bilingual editorial entries and 100 semantic groups were reviewed. The scan nominated 6 internal pairs, 280 cross-bank pairs and 4 shared-answer pairs; assistant editorial inspection resolved all as distinct relations or different works. Maximum internal English lexical similarity: 0.667.

97 source entries are used. The source ledger and research notes preserve observed URLs, factual evidence and distinctions between original recording, writing, production and reissue credits. Sources were retrieved or reviewed through indexed content during research. Static validation checks evidence mapping and source syntax; it does not independently prove facts or promise a live fetch of every URL. Editorial review is by the assistant, not an independent human editor.

Passed commands:

- `pwsh -NoProfile -File tool/generate_international_music.ps1`
- `node tool/international_music_similarity.js international_music --save`
- `node tool/international_music_shared_answers.js --save`
- `pwsh -NoProfile -File tool/validate_international_music.ps1 -WriteCandidates -WriteReport`

Protected-file hash validation reports zero changed completed-category files across the 21 previous certified categories. Only the new bank's import, catalog mapping and playable-category registration were appended. UI and gameplay files were not modified. Existing normal game selection and 200/400/600 values remain in place. Dart/Flutter executables are unavailable; the full PowerShell/static workflow was used, and runtime Flutter tests were not run.

Validation details: `content/international_music/validation_result.json`. Evidence and review ledgers: `content/international_music/`.
