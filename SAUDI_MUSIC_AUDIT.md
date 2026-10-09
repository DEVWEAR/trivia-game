# Saudi Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Saudi Music / أغاني سعودية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

The bank contains 204 original bilingual questions in six generated Dart files of 34 questions each. Its 79 used source entries include official artist and publisher recording credits, the Saudi Music Commission, Saudipedia, Saudi Aramco's Qafilah, Rotana, Billboard Arabia, established Saudi newspapers and first-person artist interviews. Evidence and actual URLs are recorded in content/saudi_music/sources.psv and evidence_ledger.csv. No song lyrics were reproduced.

All prompts and answers received assistant review for Arabic/English parity, attribution, category relevance and difficulty. Easy questions emphasize familiar repertoire and performer recognition; medium questions require album, composer, musical-tradition and artist-background knowledge; hard questions cover lyricists, arrangers, musical modes, historical ensembles, recording engineering and precisely attributed historical details. The review covers 86 semantic groups. Different credited roles are separate relations; inverse questions about the same identity were excluded.

The assistant reviewed 223 internal similarity flags, 420 cross-bank flags and 354 shared-answer flags against all 18 previously completed banks. These are candidate counts, not unresolved duplicates. Their hash-bound decisions record zero unresolved overlaps. Shared artists, formulaic credit questions and common geographic answers were checked against the actual work and requested attribute. Maximum English token similarity is 0.818. Protected facts about Zaman Al Samt's performer and Talal Maddah's first radio song were excluded. Conflicting Ala Moodak composer credits were excluded. Fazet Men Nomi explicitly asks about a dated Saudi cover performance, rather than claiming the singer originated the song. Majid Al Mohandis's repertoire is included as that of a naturalized Saudi artist.

Validation passed with zero duplicate IDs, Arabic/English questions and fact keys; zero missing questions, answers, translations or sources; zero wrong category IDs, invalid point mappings or URL syntax; zero stale or unresolved editorial, fact-family, similarity, cross-bank or shared-answer reviews; and zero changed files in both completed-category hash manifests. Only bank imports and playable registration were appended. UI and gameplay were preserved.

Passed commands:

```powershell
./tool/generate_saudi_music.ps1
node tool/saudi_music_similarity.js saudi_music --save
node tool/saudi_music_shared_answers.js --save
node tool/record_saudi_music_editorial_review.js
./tool/validate_saudi_music.ps1 -WriteCandidates -WriteReport
```

Static validation checks evidence mapping and URL syntax, rather than fetching every page again. Indexed official recording descriptions were used where direct video retrieval was unavailable; the evidence ledger identifies this. Editorial review is by the assistant, not an independent human review or a guarantee of exhaustive semantic detection. Dart and Flutter were unavailable on PATH, so executable Dart/Flutter tests, formatting and analysis could not run. PowerShell and Node supplied static checks.

The certified library now contains 19 categories and 3,876 questions. Six categories in the current ten-category batch are complete, with 1,224 questions. Egyptian Music follows next in catalog order; the final batch audit remains pending until all four remaining categories pass.
