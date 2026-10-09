# La Liga — completed content audit

Completed 2026-10-07: 204 independently written bilingual questions, exactly 68 easy200, 68 medium400 and 68 hard600. The six generated Dart batches are imported and spread once, with the final list connected to the existing catalog and playable registry.

137 source entries support the questions, primarily LALIGA, RFEF, official clubs and UEFA, with Guinness record evidence where appropriate. Actual researched URLs and specific supporting claims are recorded in sources.psv and the per-question evidence ledger. Arabic and English were read side by side and ask the same facts. Easy questions cover recognisable club/player identities and major moments; medium questions require league knowledge; hard questions cover specialist historical roles, origins and landmark performances.

Official pages were checked critically. Excluded dated scoring/appearance rankings, the mistaken location in the Messi 2014 story, Forlan's obsolete Villarreal ranking, the incorrect Cules street explanation, the false youngest-ever claim/weekday in the first-Messi-goal anniversary article and conflicting elapsed-minute descriptions of Bueno's four goals. Athletic eligibility is birth OR development in Basque academies; the 2012 academy XI occurred after a substitution, not at kickoff. No commercial trivia text was copied.

All 204 rows have hash-bound factual, bilingual, difficulty and distinct-fact review. Eighteen thematic fact families cover the entire bank. Ten internal lexical candidates and 59 comparisons against the eight completed banks were reviewed with explicit hash-bound decisions. Nine additional identical-answer cross-bank pairs were read and documented: different players, transfers, matches, countries or kit/flag attributes. The reviewer fails closed on new/stale candidates. Same club nicknames or grounds are not repeated in reverse; separate scoring actions and different matches are explained in the family review.

PowerShell/static validation passed:

| Check | Result |
|---|---:|
| Total | 204 |
| easy200 / medium400 / hard600 | 68 / 68 / 68 |
| Duplicate IDs / Arabic questions / English questions / fact keys | 0 / 0 / 0 / 0 |
| Missing sources / translations / individual bilingual fields | 0 |
| Wrong category IDs / invalid HTTPS URL syntax | 0 / 0 |
| Unresolved editorial / family / internal / cross-bank / shared-answer overlaps | 0 |
| Changed completed-category files | 0 |
| Catalog and playable registry integration | PASS |

Maximum English token similarity: 0.75. URL validation checks syntax and correspondence to researched evidence; it does not promise permanent HTTP availability. Dart/Flutter are unavailable, so compilation/runtime tests were not run. Static checks verify Dart/PSV correspondence, source mapping, imports, spreads, globally unique category IDs, registry integration and preservation hashes. UI and gameplay files were not edited.

Regenerate: ./tool/generate_la_liga.ps1
Validate: ./tool/validate_la_liga.ps1
Review records: content/la_liga
Next authorized category: Serie A. Do not regenerate completed banks.
