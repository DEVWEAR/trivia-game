# UAE Football — completed 2026-10-07

Status: COMPLETE. The active repository bank contains exactly 204 independently worded bilingual questions, divided 68/68/68. Net growth from the old 102-question bank is 102. The original six files were replaced because they included repeated facts and weak or ambiguous entries. Versioned v2 IDs prevent changed facts from inheriting an old question identity.

The existing gameplay still imports `lib/data/questions/uae_football_final.dart`. Its public list name is unchanged. The aggregator now imports six explicit 34-question Dart batches. No UI, timer, scoring, board-selection or gameplay file was changed in this pass. No category 2 question work was performed.

## Final validation

Executed `./tool/validate_uae_football.ps1 -WriteReport` with exit code 0.

| Check | Result |
|---|---:|
| Total | 204 |
| easy200 | 68 |
| medium400 | 68 |
| hard600 | 68 |
| Duplicate IDs | 0 |
| Duplicate normalized Arabic questions | 0 |
| Duplicate normalized English questions | 0 |
| Duplicate canonical fact keys | 0 |
| Missing sources | 0 |
| Missing translations | 0 |
| Wrong category IDs | 0 |
| Unresolved near-duplicate candidates | 0 |

The validator reads the active Dart imports and constructors, compares every bilingual question/answer and source with the editorial data, checks the six list declarations/spreads, HTTPS source URLs, verification dates, globally unique UAE IDs and distribution. This is static validation; it does not claim to execute Dart.

## Evidence and editorial review

The three PSV files in `content/uae_football/` hold 68 questions each. `sources.psv` contains real research URLs and supporting fact summaries. `evidence_ledger.csv` maps all 204 IDs and canonical facts to their answers and evidence. Facts were checked against accessible official reports, historical guides, club pages and contemporary reporting. Sources favour FIFA, AFC, UAE Pro League and official clubs. Khaleej Times, Arab News, The National and government-owned Sharjah24 provide a small number of historical details where accessible primary material was limited.

Arabic and English were reviewed together: same requested person, club, competition, edition, result, date and answer. Historical Al Ahli and Al Shabab names are preserved where appropriate. Asian Cup 2023 refers to the official tournament edition played in January 2024. Questions about 2025-26 and cumulative records are explicitly dated. No undated current title or goal totals are used. For question 203, the FIFA retrospective contains an erroneous 32-goal total: the league organizer and the contemporary AFC Quarterly Issue 21 confirm 33 (31 before the final game, then two goals). The answer uses 33 and cites the league organizer.

Difficulty review uses familiarity and depth: 200 covers recognised milestones, stars and club identities; 400 covers established tournament runs, champions, notable coaches and club history; 600 covers less familiar qualifying details, historic results, decisive shootout players and specific long-standing records. Hard questions do not rely on incidental minute numbers or administrative quotas. Multi-name answers identify every required name.

Two misleading easy prompts were corrected: the 2020 AFC guide question asks for the stadium listed in the guide rather than claiming matches were played there; the 2019 league question no longer names its answer. A group-letter question and a familiar recent coach question were replaced with a Gulf final result and Ajman's historic cup-winning coach. A repeated focus on one recent Sharjah final was reduced by adding Fahad Khamees's historic league record.

## Fact overlap review

All 204 canonical fact keys were reviewed across tiers, including reverse questions and facts phrased under different names. No repeated tested fact remains. Separate facts about the same significant match (opponent, decisive scorer, coach or result) are retained only where they require distinct knowledge; answer identity alone is not treated as duplication.

The programmatic scan flags English token Jaccard similarity of at least 0.60, plus identical answers within the same event family. All 36 final candidates were manually reviewed as distinct facts. `near_duplicate_review.csv` records an individual reason and SHA-256 fingerprint for each pair. The validator rejects missing decisions or changed question/answer text. Similar templates for different clubs or editions are documented explicitly rather than silently exempted.

## Coverage

| Editorial topic | Questions |
|---|---:|
| Senior national team | 27 |
| Youth and Olympics | 19 |
| Gulf competitions | 14 |
| UAE clubs in Asian/world competitions | 25 |
| Domestic competitions | 26 |
| Club identities and stadiums | 19 |
| Club history | 16 |
| Players | 34 |
| Coaches | 15 |
| Records | 9 |
| Total | 204 |

Only 24 questions explicitly mention Al Ain in the prompt or answer. The bank also covers Nasr, Wasl, Jazira, Wahda, Sharjah, Bani Yas, Shabab Al Ahli and predecessor clubs, Ajman, Emirates, Shaab, Dhafra, Khorfakkan and Kalba.

## Reproduction and limitations

1. Edit the relevant PSV, preserving original bilingual wording and evidence.
2. Run `./tool/generate_uae_football.ps1`.
3. Run `./tool/validate_uae_football.ps1 -WriteCandidates` and review any new/stale pairs individually.
4. Run `./tool/validate_uae_football.ps1 -WriteReport` and `./tool/update_question_progress.ps1`.

Dart and Flutter are unavailable on PATH. Flutter analysis, runtime tests and UI launch were therefore not executed. PowerShell/static validation passed, and the existing gameplay imports the completed bank. Static checks cannot independently prove factual accuracy or language equivalence; the sourced editorial review above supplies those checks. Difficulty is editorially calibrated, not measured through player testing.

