# Saudi Arabia — completed editorial audit

Verified on 7 October 2026. The active bank is `lib/data/questions/saudi_general_final.dart`, generated as six batches of 34 from the three editorial PSV files.

204 questions: 68 easy200, 68 medium400 and 68 hard600. PowerShell/static validation passed. Duplicate IDs, normalized Arabic questions, normalized English questions, canonical fact keys, missing sources, missing translations, invalid source URLs and wrong category IDs are all zero.

The evidence ledger maps all questions to 135 used source entries. These include Saudi ministries and authorities, Ministry of Media Saudipedia, UNESCO, official museums, university libraries, Aramco, Saudi Central Bank, official film organizers/distributors and artists, FIFA, AFC and Formula 1. Retrieved pages or indexed source text support the recorded evidence. Some government pages are client-rendered or intermittently inaccessible; those limitations are recorded rather than represented as successful full-page retrievals. No source URLs were fabricated.

All 204 bilingual pairs were reviewed for source support, equivalent requested facts, natural Arabic and difficulty. Thirty-six semantic families were reviewed across the whole bank, including low-lexical-similarity relationships. Eight internal lexical candidates and eighteen comparisons with the five completed banks were explicitly resolved as distinct facts. Unresolved internal and cross-bank overlaps are zero; candidate counts remain visible. Maximum English token similarity is 0.818.

Coverage includes geography, founding history, national symbols, Saudi institutions, education, early oil exploration, archaeology, historic places, transport, conservation, regional food and crafts, poetry and literature, contemporary art, television, cinema, national football and other sports. Easy questions emphasize recognizable knowledge, medium questions established national knowledge and hard questions specialist historical, cultural, architectural, industrial and sporting recall.

Editorial exclusions and corrections include conflicting palace construction dates, disputed first-state chronology calculations, an incorrect highest-peak claim, uncertain ancient royal genealogy, conflicting discovery-day conversions, changing venue capacity and prize money, unsupported rice health claims and Saudi 1996 final facts already used by UAE Football. Generic Gulf coffee, Ardah, Qatt, Khawlani cultivation, Taif rose and Alwan novel facts were excluded because completed banks already use them. The redundant Jeddah Red Sea question was replaced; WAS and bisht questions were rewritten to avoid answer giveaways. Royal Salute arrangement is distinguished from original composition. Memory of the World is distinguished from World Heritage inscription.

Static validation checks exact counts, all fields and Arabic/English scripts, generated/editorial parity, source mapping and URL structure, six imports/spreads, repository-wide ID definitions, hash-bound editorial/family/candidate reviews, playable registry wiring and completed-file preservation. These checks do not automatically prove factual accuracy or difficulty; the recorded editorial review provides that judgment.

Preservation comparison found zero changes to completed-category files. Saudi Arabia was appended to the catalog and playable registry. Existing indexes, UI, board logic, manual scoring, timers and language behavior were preserved. Dart and Flutter are unavailable, so runtime analysis and Flutter tests were not executed.

Validation command: `./tool/validate_saudi_general.ps1`. All content, generated batches, audit and category tools are protected by `BATCH_4_13_COMPLETED.json` for subsequent batch work.
