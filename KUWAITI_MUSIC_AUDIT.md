# Kuwaiti Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Kuwaiti Music / أغاني كويتية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

Resumed the existing 60 questions and added 144 original bilingual questions. Six generated Dart files contain 34 questions each. Only question-bank imports and playable registration were appended; UI, gameplay, scoring and selection rules were preserved.

The 85 used source entries include official artist and publisher recording credits, Rotana, Awakening Music, Kuwait's 51 audiovisual archive, Sheikh Jaber Al Ahmed Cultural Centre, KUNA, composers' own catalogues, licensed music catalogues and direct artist interviews. The source ledger records the evidence inspected during authoring. No lyrics were reproduced. Original recording, revival, cover and reupload credits were distinguished. Conflicting composer attributions for the Yijeeb Allah Matar theme were excluded; only its confirmed singer is used. No unconfirmed future release was used.

All 204 Arabic/English prompts and answers were read and reviewed by the assistant for factual attribution, translation parity and difficulty. Easy questions emphasize performer and familiar repertoire recognition; medium questions cover composers, albums, collaborations and artist background; hard questions require specialist historical, lyricist, arrangement, production or musical-mode knowledge. The review covers 124 semantic groups. Multiple questions about a work request distinct credited roles or attributes, rather than inverse questions about the same fact.

The assistant inspected 30 internal similarity candidates, 463 cross-bank candidates and 101 shared-answer candidates. Matching templates, artists and instruments were distinguished from repeated entity/attribute facts. The review includes all 17 previously completed banks, particularly Emirati Music and Gulf Music. The protected Shadi Al Khaleej stage-name fact and Sawt instrumental facts were avoided while authoring. Maximum internal English token similarity is 0.714. Hash-bound editorial and candidate inventories record zero unresolved overlaps. This is assistant editorial review, not independent human review or a guarantee of exhaustive semantic detection.

Validation passed with zero duplicate IDs, normalized Arabic/English questions and fact keys; zero missing questions, answers, translations and sources; zero invalid category IDs or difficulty/point mappings; zero invalid HTTPS URL syntax; zero stale or unresolved editorial, semantic-group, near-duplicate, cross-bank or shared-answer reviews; and zero changed files in both completed-category protection manifests.

Passed commands:

```powershell
./tool/generate_kuwaiti_music.ps1
node tool/kuwaiti_music_similarity.js kuwaiti_music --save
node tool/kuwaiti_music_shared_answers.js --save
node tool/record_kuwaiti_music_editorial_review.js
./tool/validate_kuwaiti_music.ps1 -WriteCandidates -WriteReport
```

Static validation checks evidence mapping and URL syntax; it does not claim to fetch every source at validation time. Indexed official descriptions were used where direct video fetches were unavailable, as recorded in the ledger. Dart and Flutter were unavailable on PATH; formatting, analysis and executable Dart/Flutter tests could not run. PowerShell and Node supplied static verification.

The completed library now contains 18 certified categories and 3,672 certified questions. Five categories in the current ten-category batch are complete (1,020 questions); Saudi Music is next. Legacy, uncertified inventory is separate from these totals. The final ten-category audit remains pending until the remaining five categories are finished.
