# Football Legends audit

Verified and validated 2026-10-07. COMPLETE under the repository's static and assistant editorial workflow.

| Category | Total | easy200 | medium400 | hard600 | Exact duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Football Legends | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE |

The existing easy and medium sets were retained, except necessary replacements of repeated facts detected against protected banks. Only the unfinished hard set was extended. Repeated facts about Zamorano's 1+8 shirt, Weah's first European club and a Cubillas free-kick were removed from this unprotected bank. The protected banks were unchanged.

All 204 entries have bilingual questions and answers, source evidence and hash-bound source, translation, difficulty and distinct-fact reviews. The bank uses 163 source entries, including official FIFA, UEFA, AFC, CAF, national associations, clubs and primary institutional records; reliable reporting supplements historical facts. Time-dependent honours and events specify the relevant year or competition.

The assistant reviewed 152 player fact families, 28 internal similarity candidates, 49 cross-bank similarity candidates and 105 shared-answer comparisons. The comparison scope covers all 13 previously completed categories plus World Cup. Shared names, separate dated events, different awards and credited match roles were assessed individually. These are assistant editorial decisions, not an independent human audit or a mathematical guarantee of semantic uniqueness.

Passed: `./tool/generate_football_legends.ps1`; `node tool/record_football_legends_editorial_review.js`; `./tool/validate_football_legends.ps1 -WriteReport -WriteCandidates`.

Validation also returned zero duplicate fact keys, missing answers, wrong category IDs, invalid difficulty mappings, invalid source URL syntax, stale editorial reviews, unresolved fact-family reviews, unresolved cross-bank comparisons and changes to protected files. Source evidence is in `content/football_legends/evidence_ledger.csv`; full results are in `content/football_legends/validation_result.json`.

The category was registered through the existing data registry. UI and gameplay files were not edited. The existing point enum and picker/board registry use passed static checks. Dart and Flutter are unavailable on PATH, so Dart formatting, analysis, runtime tests and a visual gameplay test could not run. Static validation does not establish that every source URL will remain live in future.
