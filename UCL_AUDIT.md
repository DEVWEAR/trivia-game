# Champions League — COMPLETE

Validated 2026-10-07: 204 questions, 68 easy200, 68 medium400, 68 hard600.

Zero duplicate IDs, normalized Arabic questions, normalized English questions, fact keys, missing fields, missing sources, missing translations, invalid source URLs or wrong category IDs. All 204 source/translation/difficulty reviews and 93 semantic groups passed. Fifteen bilingual similarity candidates, 26 cross-bank candidates and 89 shared-answer comparisons were reviewed; unresolved counts are zero. Maximum English Jaccard similarity: 0.733.

Evidence: 68 used official UEFA sources, with URLs and independently written bilingual questions in content/ucl. Coverage includes European Cup origins, early champions, notable finals, knockout comebacks, group-stage upsets, scoring and age records, North African stars, anthem, trophy and competition format. Sources were inspected through official indexed pages, match reports and match records. No commercial trivia source was used. No placeholders or inverse questions were retained.

Editorial corrections: removed the city-answer clue from the Celtic nickname question; specified group-stage-to-final scope for the Ronaldo career record; removed an unnecessary year clue from the old competition name. Moved Origi's memorable final goal to easy, Pepe's age milestone to medium, the 1993 Galatasaray upset to hard, Lahm's captaincy to medium and Foden's injury-replacement role to hard. Goalscorers, assistants, captains and venues were reviewed as independent match relations. Roma first-leg own goals are separate from second-leg scoring contributions.

Excluded contradictory archive details: 1956 historical PDF lineup, 1970 Celtic–Leeds venue/score order, and the 2015 Neymar assist attribution in an annual PDF. The match report credits Pedro, used here. Rolling 2026 hat-trick and fixture claims were not used for historical questions. Ricken's chipped goal is supported by the separate UEFA match report.

Generated six Dart batches and connected the bank to the existing catalog and playable registry. Existing completed-bank hashes passed unchanged. No UI or gameplay file was edited. Flutter/Dart are unavailable; PowerShell and Node static validation passed.

Run: `pwsh -NoProfile -File tool/validate_ucl.ps1`

Evidence ledger and exact-wording review hashes: content/ucl/evidence_ledger.csv, editorial_review.csv, fact_family_review.csv, near_duplicate_review.csv, cross_bank_review.csv and shared_answer_review.json. New or changed candidates fail validation until reviewed.
