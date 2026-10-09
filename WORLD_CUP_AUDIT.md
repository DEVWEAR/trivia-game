# World Cup audit

Status: COMPLETE — 2026-10-07.

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| كأس العالم / World Cup | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE |

119 source entries support the bilingual questions, principally FIFA with UEFA, AFC and national federation evidence. Historical editions are explicit; women's questions identify the women's competition. The 204 question reviews cover source evidence, translation parity and difficulty. The semantic review covered 139 event families, 96 bilingual similarity candidates, 67 cross-bank wording candidates and 80 shared-answer candidates. All decisions are bound to exact content hashes. The repeated Croatia 2018 final fact and shared trophy-material fact were replaced before validation.

Passed: `./tool/validate_world_cup.ps1 -WriteReport -WriteCandidates`, generation parity, global ID uniqueness, source URL structure/evidence mapping, enum point mapping, playable registry and preservation checks. All 328 protected prior-category files remain byte-for-byte unchanged. See `content/world_cup/validation_result.json`, evidence ledger and review files. Static checks do not independently prove facts; source and bilingual editorial review supplies that evidence.

Dart/Flutter are unavailable; formatting, analyzer, runtime and Dart tests were not run. No UI or gameplay code changed. Data registration adds the completed bank to the existing catalog and playable registry. The next category is Football Legends.
