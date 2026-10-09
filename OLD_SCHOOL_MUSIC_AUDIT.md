# Old School Music — completed bank audit

2026-10-08. 204 original bilingual questions are active in the existing schema and playable catalog: 68 easy200, 68 medium400, 68 hard600.

| Total | easy200 | medium400 | hard600 | Duplicate IDs | Duplicate Arabic | Duplicate English | Missing sources | Missing translations | Status |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | 0 | COMPLETE |

Wrong category IDs, invalid difficulty/point mappings, missing answers, stale editorial reviews, unresolved fact-family reviews, unresolved near-duplicate facts, unresolved cross-bank overlaps and changed protected files: zero.

The assistant read all 204 Arabic/English question and answer pairs and reviewed difficulty and evidence. The 89 semantic groups cover distinct recording, performer, composer, lyricist, album, production, instrument, venue, film and award relations. 62 bilingual lexical candidates, 340 comparisons against all 22 preceding completed banks and 173 additional shared-answer pairs were inspected and recorded with hashes. Similar wording and repeated artists across different named works are not repeated underlying facts. Maximum English Jaccard similarity: 0.778. These are assistant editorial reviews, not independent human certification or a proof of exhaustive semantic detection.

93 evidence entries were retrieved or indexed from official artist/estate and label records, the Recording Academy, Academy of Motion Picture Arts, Library of Congress, BNF, Tunisian National Sound Archive, Doha Film Institute, Bahrain cultural authority, Arab Music Academy, published music scores, documentary producers, first-person interviews and established music journalism. A URL syntax check does not establish permanent live availability. No source URLs were constructed from guesses.

The final credit review rejected the erroneous Fares Al Abdallah attribution in a 2011 concert report: original release metadata and the lyricist's first-person interview identify Omar Batisha for Haramt Ahebak. Jolene credits distinguish producer Bob Ferguson from executive producer Dolly Parton. Conflicting historical release years and stage-premiere claims were not used. Familiar poem authors were kept at medium difficulty; specialist maqam and film details were reviewed at hard difficulty. No song lyrics are reproduced in questions or answers.

Validation: `pwsh -NoProfile -File tool/validate_old_school_music.ps1`; Node bilingual similarity and shared-answer scans; generated Dart/PSV equality, source and review mapping, registry wiring, 200/200/400/400/600/600 rules and protected SHA-256 checks. UI and gameplay implementation files were preserved. Only the existing catalog wiring adds the completed bank. Dart/Flutter are unavailable, so formatting, analysis, runtime and Dart tests were not executed.
