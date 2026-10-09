# Premier League — completed content audit

Verified and statically validated on 2026-10-07. The active repository bank contains 204 independently written bilingual questions: 68 easy200, 68 medium400 and 68 hard600. Six Dart batches are imported once by the final aggregator and wired into the catalog and playable registry.

## Evidence and editorial review

109 source entries are used. Evidence comes from the official Premier League, official clubs, UEFA and The FA. Source URLs were taken from actual research results/pages. The PSV source ledger records the supporting claim; the generated evidence ledger maps each individual question to its source. Natural Arabic and English ask the same fact. Easy questions cover recognisable players, clubs and iconic moments; medium questions require established league knowledge; hard questions concern specialist historical details, landmark match roles and technical history.

Excluded obsolete player rankings and unsupported claims in otherwise official pages. For example, old Drogba African scoring records, Rooney's old career rank, historic fastest-goal claims, ambiguous transfer fees and the erroneous Forest ground name in Southampton's guide were not used. Kluivert's three-penalty match, goalkeeper goals and different match events are explicitly dated. Ferguson's retirement season was replaced with a more specialist Solskjaer transfer-origin question during difficulty review. No commercial trivia wording was copied.

## Duplicate and semantic review

All 204 questions received hash-bound source, translation, difficulty and distinct-fact review. Twenty-one fact families cover every row. The bilingual lexical scan flagged 16 internal pairs and 57 comparisons with the seven completed banks; each was reviewed and given a hash-bound explanation. Shared question grammar for different club nicknames, grounds and derby pairings is not a repeated fact. Inaugural Deane goal differs from next-day Sheringham televised goal. City 2012 final winner, assist and equaliser are separate actions. Premier League clean-sheet Golden Glove criteria differ from the protected UAE Best Goalkeeper award-name fact.

The review generator fails on new or changed candidates without a corresponding explicit decision. Manual fact-family review also covers semantic overlaps that lexical matching alone can miss. Avoided repeating protected UAE football player-club transfer facts. Repeated answer names across different factual relations are permitted; repeated or reverse fact questions are not.

## Validation result

`tool/validate_premier_league.ps1 -WriteCandidates -WriteReport` passed:

| Check | Result |
|---|---:|
| Total | 204 |
| easy200 / medium400 / hard600 | 68 / 68 / 68 |
| Duplicate IDs / Arabic questions / English questions / fact keys | 0 / 0 / 0 / 0 |
| Missing sources / translations | 0 / 0 |
| Wrong category IDs / invalid HTTPS URL syntax | 0 / 0 |
| Unresolved editorial / family / internal overlap / cross-bank reviews | 0 / 0 / 0 / 0 |
| Changed completed-category files | 0 |
| Playable catalog/registry wiring | PASS |

Maximum English token similarity was 0.778. The URL check validates syntax and source mapping; it is not a claim that every website will always return HTTP 200. Dart/Flutter are unavailable in this environment, so compilation/runtime tests were not run. PowerShell checked generated Dart fields, imports/spreads, distribution, global IDs, bilingual scripts, source correspondence, registry integration and preservation hashes. UI and gameplay files were not changed.
