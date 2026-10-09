# Emirati Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Emirati Music / أغاني إماراتية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

The active bank consists of six batches of 34 questions, generated from the bilingual PSV files in `content/emirati_music`. The existing question model and point mapping are preserved. Only bank imports and category registration were added; existing category indexes, UI and gameplay files were not changed.

All 204 questions have Arabic and English prompts and answers, a fact key, a source name and an actual HTTPS source URL. The bank uses 99 source entries. Evidence includes official artist and producer recordings, artist biographies, Abu Dhabi Festival, ADMAF, the Department of Culture and Tourism and WAM. Direct artist interviews and licensed catalogues supplement primary sources. Upload dates and platform catalogue dates are not asserted as historical first releases unless the source explicitly identifies them.

The assistant reviewed bilingual parity, difficulty, attribution and 121 semantic groups. Performer, lyricist, composer, arranger and album relations were inspected separately. Same-song inverse questions identifying the same credited person were avoided. An uncertain song-title transcription was replaced; the Mehad Hamad album title was checked against his own release credits; an equipment endorsement question was replaced with a sourced music-education fact. Conflicting individual movement credits for Symphony of Three were excluded.

The bilingual lexical scan produced 40 internal candidates, all reviewed. Its maximum English token similarity was 0.818. Cross-bank comparison covered all 15 previously completed banks, including World Cup and Football Legends: 8 lexical candidates and 13 common-answer candidates were reviewed as distinct relations. Matching sentence templates, city names or instruments do not by themselves identify the same underlying fact. There are zero unresolved candidates. These checks combine programmatic detection with assistant editorial review; they are not an independent human review or a proof of exhaustive semantic equivalence.

Validation passed with zero duplicate IDs, normalized Arabic prompts, normalized English prompts and fact keys; zero missing prompts, answers, translations or sources; zero wrong category IDs; zero invalid difficulty mappings; zero invalid URL syntax; zero stale or unresolved editorial, family, near-duplicate, cross-bank or shared-answer reviews. Both preservation manifests report zero changed protected files.

Passed commands:

```powershell
./tool/generate_emirati_music.ps1
node tool/emirati_music_similarity.js emirati_music --save
node tool/emirati_music_shared_answers.js --save
node tool/record_emirati_music_editorial_review.js
./tool/validate_emirati_music.ps1 -WriteReport
./tool/validate_football_legends.ps1
```

The review recorder checks the manually reviewed frozen candidate inventory before writing hash-bound decisions. Source evidence and review files are retained beside the PSV files, with the complete evidence ledger and validation JSON. The static validator verifies source mapping and URL syntax; it does not claim to have fetched every URL at validation time. Factual evidence was inspected during authoring and research.

Dart and Flutter are unavailable on PATH, so Dart formatting, analysis and executable Flutter/Dart tests were not run. PowerShell and Node performed the available static checks. The original ten-category batch remains in progress; this audit certifies Emirati Music only, not the unfinished music categories.
