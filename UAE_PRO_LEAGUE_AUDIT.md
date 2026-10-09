# UAE Pro League — completed editorial audit

Verified 7 October 2026. The active six-batch bank contains exactly 204 questions: 68 easy200, 68 medium400 and 68 hard600. `./tool/validate_uae_pro_league.ps1 -WriteCandidates -WriteReport` passed.

Duplicate IDs, normalized Arabic questions, normalized English questions, fact keys, missing sources, missing translations, wrong category IDs and unresolved editorial, family, internal and cross-bank reviews are all zero. All 204 records map to 134 used source entries. HTTPS URL structure passes; this is not an automated assertion that every server returns HTTP 200.

Sources include UAE Pro League reports, fixtures, regulations and magazines; AFC and FIFA articles and technical guides; official clubs and transfer announcements; UAE government media; and contemporary local reporting, including direct coach interviews. Retrieved source evidence is recorded in the ledger. Migrated AFC timestamps are distinguished from the historical season in the article. Conflicting or inaccessible evidence limitations are recorded in source notes.

Bilingual wording, difficulty and factual support were reviewed across all 204 records. Twenty-six semantic families include club identities, players, transfers, coaching, historical milestones, domestic cups, Gulf and Asian competitions, youth football and competition rules. Thirty-one internal lexical candidates and forty-three comparisons with the six completed banks were reviewed as distinct facts; maximum English token similarity is 0.818. Candidate counts remain visible rather than being represented as zero candidates.

The draft Bur Dubai derby pairing, Hatta geography and Khorfakkan geography were removed because completed banks already cover those facts. Repetitive Santos/Pele and Liverpool stadium-opening facts were removed. The Negredo final opening goal question excludes a conflicting eight/ten-second timing. Tadic's national-team question uses past tense. Cup editions, competition names, loan clubs and selling clubs are distinguished. Conflicting statistics, routine goal minutes, fees and arbitrary fine amounts are excluded.

Catalog and playable registry wiring passed. Completed-category preservation found zero changed files. UI, gameplay, established category indexes, scoring and timers were preserved. Dart/Flutter are unavailable; static validation was used and runtime tests were not run.
