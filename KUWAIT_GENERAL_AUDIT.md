# Kuwait — completed editorial audit

Verified on 7 October 2026. Active bank: `lib/data/questions/kuwait_general_final.dart`; six batches of 34 questions, generated from the three editorial PSV files.

## Result

204 total: 68 easy200, 68 medium400, 68 hard600. PowerShell/static validation passed. Duplicate IDs, normalized Arabic questions, normalized English questions, canonical fact keys, missing sources, missing translations, invalid source URLs and wrong category IDs: all zero.

204 hash-bound source/translation/difficulty reviews cover 46 semantic families. Fifteen internal lexical candidates and eighteen comparisons against the four completed banks were manually resolved as distinct facts; unresolved internal/cross-bank candidates: zero. Candidate counts are retained for transparency and are not suppressed to manufacture a zero result.

The evidence ledger maps each question to one of 56 used sources. Sources include Kuwait Government Online, Kuwait's UN mission, official museums and cultural centres, Kuwait University, KISR, KFAS, Kuwait Fund, UNESCO, Ramsar, FIFA, AFC, ISSF and the national carrier. Limited first-hand newspaper reports support artist names and a film director's account of the original story. URLs are retrieved source pages, not fabricated citations. Source evidence records identify factual exclusions and historical scope.

## Editorial decisions

- Removed the shrimp-in-rubyan answer giveaway and generic aquarium/theatre questions.
- Removed the generic Machboos fact already in UAE Heritage, the shared flag palette, shared official-language question and generic face-covering fact.
- Replaced a disputed independence-document signatory claim because official and other reliable accounts conflict.
- Distinguished the film's original story author from potentially shared screenplay credits.
- Combined the two Tell Said column attributes into one Greek/Persian architectural question, and combined the middle/smallest tower shape inspirations.
- Excluded disputed film release dates, conflicting coach credits, uncertain folklore, arbitrary archaeological measurements and outdated operational information.
- Checked Arabic names and local vocabulary against Arabic government sources. Each bilingual pair asks the same attribute; historical clothing/social descriptions are scoped accordingly.

Coverage includes national symbols, geography and islands, history and independence, landmarks, culture and literature, food and customs, archaeology, museums, education and science, oil and aviation, international development, humanitarian work, football and Olympic shooting. Easy questions emphasize recognizable places/people/customs; medium questions require established national knowledge; hard questions require specialist cultural, historical, institutional or sporting recall.

## Preservation and limitations

The validator compared all previously completed-category files to `BATCH_4_13_COMPLETED.json`: zero changed files. Kuwait was appended to the shared catalog and playable registry; no board rules, timers, scoring, languages, layouts or existing indexes were changed.

Run `./tool/validate_kuwait_general.ps1 -WriteReport` to repeat static checks. Generated/editorial parity, source mapping, translation presence/script, source URL structure, exact distribution, import/spread membership, global ID definitions, hash-bound editorial/family/candidate decisions, playable wiring and preserved-file hashes are checked. Factual correctness and difficulty rely on the recorded human editorial review; syntactic validation does not prove them automatically.

Dart/Flutter are unavailable in this environment; runtime analysis and Flutter tests were not executed.
