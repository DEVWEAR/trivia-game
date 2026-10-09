# Gulf Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Gulf Music / أغاني خليجية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

The bank is implemented in six Dart batches of 34 questions, generated from `content/gulf_music`. The existing schema, scoring and question-selection rules are preserved. Data imports and playable registration were added at the end of the existing registry; UI and gameplay files were not changed.

All 204 bilingual prompts and answers have source evidence. The bank uses 94 source entries, including official artist and publisher credits, Rotana and Platinum Records, Dubai Media, Bahrain's Culture Authority, Qatar Music Academy and Royal Opera House Muscat. Direct composer interviews and licensed catalogues supplement primary evidence. Uploads and catalogue dates are distinguished from historical release dates; conflicting dates and changing view totals were excluded.

The assistant read the Arabic and English questions, reviewed difficulty and attribution, and checked 115 semantic groups. Accessible performer/song recognition is separated from composer, album and collaboration recall and specialist historical, lyricist, arrangement and orchestral credits. Composer, lyricist, performer and production roles refer to distinct credited relations; same-work inverse identities were avoided. Arabic title transliteration and English personal-name consistency were corrected during review. The two nickname facts already present in Kuwait and Saudi Arabia were replaced in this bank.

The final scan contains 70 internal lexical candidates, 255 cross-bank lexical candidates and 35 shared-answer candidates. Every candidate was inspected before the inventory was frozen and hash-bound review decisions were recorded. Maximum English token similarity is 0.818. Comparison covers all 16 previously completed banks, including World Cup, Football Legends, the leagues, Champions League and Emirati Music. Common people, cities, templates and instruments were distinguished from repeated entity/attribute facts. Zero unresolved near-duplicates and cross-bank overlaps remain. This is assistant editorial review, not independent human review or a guarantee of exhaustive semantic detection.

Validation passed with zero duplicate IDs, normalized Arabic questions, normalized English questions and fact keys; zero missing questions, answers, translations and sources; zero wrong category IDs and invalid difficulty/point mappings; zero invalid HTTPS URL syntax; zero stale/unresolved editorial, semantic-group, near-duplicate, cross-bank and shared-answer reviews. Both protection manifests report zero changed completed files.

Passed commands:

```powershell
./tool/generate_gulf_music.ps1
node tool/gulf_music_similarity.js gulf_music --save
node tool/gulf_music_shared_answers.js --save
node tool/record_gulf_music_editorial_review.js
./tool/validate_gulf_music.ps1 -WriteReport -WriteCandidates
```

The source ledger records evidence inspected during authoring. Static validation checks mapping and URL syntax; it does not claim to fetch every source at validation time. The review recorder rejects candidate inventories that differ from the manually reviewed snapshot.

Dart and Flutter are unavailable on PATH, so formatting, analysis and executable Dart/Flutter tests could not run. PowerShell and Node provided the available static validation. The ten-category batch remains in progress; this report certifies Gulf Music only.
