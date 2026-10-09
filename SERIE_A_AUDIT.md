# Serie A — completed content audit

Completed 2026-10-07: 204 original bilingual questions, exactly 68 easy200, 68 medium400 and 68 hard600. Six generated Dart batches are imported and spread once. The final bank is connected to the catalog and existing playable registry.

138 source entries support the questions, using official clubs, Lega Serie A, FIGC and UEFA. Researched URLs and supporting claims are recorded in sources.psv and evidence_ledger.csv. Every Arabic/English question and answer was read for fact parity; difficulty was reviewed and several questions moved between tiers. Two weak hard questions were replaced by substantive historical questions. The bank includes major and smaller clubs, awards, derbies, records, coaches, domestic cups, European achievements, debuts, club identities and stadium history.

Official evidence was checked critically. Excluded an erroneous UEFA article claim that Nakata was the first Japanese player in Serie A. Avoided misleading first-southern-champion and youngest-appearance claims. Used approximate seven-second wording for Leao rather than conflicting exact time measurements. Buffon's debut clean sheet has explicit corroborating Juventus evidence. No commercial trivia questions were copied.

All 204 rows have hash-bound source, bilingual, difficulty and distinct-fact editorial records. Twenty fact-family reviews cover the full bank. Thirteen internal lexical candidates, 29 cross-bank lexical candidates against all nine completed categories and 19 identical-answer cross-bank pairs were manually reviewed and documented. Different clubs, campaigns and roles are distinguished; inverse questions about the same fact were excluded. Review records fail closed when question text or evidence changes.

PowerShell/static validation passed:

| Check | Result |
|---|---:|
| Total | 204 |
| easy200 / medium400 / hard600 | 68 / 68 / 68 |
| Duplicate IDs / Arabic questions / English questions / fact keys | 0 / 0 / 0 / 0 |
| Missing sources / translations / individual bilingual fields | 0 |
| Wrong category IDs / invalid HTTPS URL syntax | 0 / 0 |
| Unresolved editorial / family / internal / cross-bank / shared-answer checks | 0 |
| Changed completed-category files | 0 |
| Catalog and playable registry | PASS |

Maximum English token similarity: 0.733. Source syntax validation checks researched URL mapping, not permanent website availability. Dart/Flutter are unavailable, so compilation and runtime tests were not executed. Static checks verify Dart/PSV correspondence, evidence mapping, six imports/spreads, global category ID uniqueness, playable integration and completed-file preservation. UI and gameplay files were not edited.

Regenerate: ./tool/generate_serie_a.ps1
Validate: ./tool/validate_serie_a.ps1
Review records: content/serie_a
Next authorized category: Bundesliga. Preserve all completed banks.
