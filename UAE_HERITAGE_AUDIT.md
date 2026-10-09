# Category 3 — تراث الإمارات / UAE Heritage

Completed and reviewed: 2026-10-07. Category ID: `uae_heritage`.

## Production bank

The active catalog imports `lib/data/questions/uae_heritage_final.dart`, which combines six explicit batches of 34 questions. It replaces the former 20-question list; the obsolete list was removed. There are exactly **204 questions: 68 easy200, 68 medium400 and 68 hard600**. No UI or gameplay files were changed.

The independently written bilingual editorial originals are `content/uae_heritage/easy.psv`, `medium.psv` and `hard.psv`. Each question has its own ID and tested-fact key, an Arabic and English prompt and answer, a named primary source, an actual HTTPS source URL and verification date. No commercial trivia bank was used.

## Evidence and editorial review

75 source entries are used. Sources are Abu Dhabi's Department of Culture and Tourism, Dubai Tourism, Sharjah Tourism, Ras Al Khaimah Tourism, the UAE Ministry of Culture and UNESCO. `sources.psv` records the supporting passages in paraphrased evidence notes; `evidence_ledger.csv` joins every question to its source and evidence.

Coverage includes clothing, adornment, food and hospitality, pearling, fishing, shipbuilding, desert migration, camels and salukis, falcon training, weaving and other crafts, domestic tools, historic occupations, architecture and forts, games, oral performance and poetry, majlis culture, weddings, Eid and Haq Al Laila, and UNESCO-recognised practices.

Arabic sources were consulted to resolve specialist terminology. Corrections included the shipbuilding caulker versus the general shipwright, the saqa tripod versus its separate pole, the kufa weight, the serving spoon, the dried jami product, the vessel name saffar and the hair powder al bidaah. Unsupported medical assertions appearing in some historical accounts were excluded. The questions describe documented customs without claiming every family practised an identical version.

Difficulty review uses familiar cultural recognition and everyday customs for 200, specific practices and less familiar objects for 400, and specialist vocabulary, craft patterns/components and historical details for 600. `editorial_review.csv` records evidence, translation parity, difficulty and fact-distinctness review for every question. Review hashes include both languages, answers, difficulty, fact identity, source name/URL and evidence; changing these invalidates the review.

## Duplicate and near-duplicate review

All 20,706 unordered question pairs were scanned for English and Arabic token similarity and repeated answers in the same fact family. One pair exceeded the 0.60 candidate threshold: the UNESCO inscription years for Ayyala and Razfa. It asks about different performances, distinct inscriptions and different years, and has a specific recorded decision in `near_duplicate_review.csv`. Maximum English similarity is 0.611, below the shared Dart validator's 0.85 threshold.

The manual semantic review covers all 204 questions across 121 groups in `fact_family_review.csv`, including related subjects across different fact-key prefixes. It checks definitions against reverse questions, different roles/tools within a craft, ingredient identification, chronology, named games and UNESCO events. Reverse bread/griddle identification and a repeated boat-caulking material relation were removed during review. Coffee questions distinguish different actors and actions; Ayyala questions distinguish instruments, formation, held objects and symbolism; historic-site questions test separate attributes. There are **zero unresolved near-duplicate facts**.

## Validation

Run from the project root:

```powershell
./tool/generate_uae_heritage.ps1
./tool/validate_uae_heritage.ps1 -WriteCandidates -WriteReport
./tool/update_question_progress.ps1
```

The validator reads the actual six imported Dart batches, checks catalog wiring and import/spread consistency, compares every stored field against the editorial originals, checks ID uniqueness across `lib`, normalises both languages for duplicates, verifies source mapping and review freshness, checks the complete semantic review and checks SHA-256 preservation of both completed categories.

| Check | Result |
|---|---:|
| Total | 204 |
| easy200 | 68 |
| medium400 | 68 |
| hard600 | 68 |
| Duplicate IDs | 0 |
| Duplicate Arabic questions | 0 |
| Duplicate English questions | 0 |
| Duplicate tested-fact keys | 0 |
| Missing sources | 0 |
| Missing translations | 0 |
| Wrong category IDs | 0 |
| Unresolved near-duplicate candidates | 0 |
| Unresolved semantic-group reviews | 0 |
| Unresolved evidence/translation/difficulty reviews | 0 |
| Changed completed-category files | 0 |

The machine-readable result is `content/uae_heritage/validation_result.json`. UAE Football and UAE source banks, content ledgers, generation/validation scripts and audit reports remain byte-for-byte unchanged against `CATEGORY_3_PRESERVATION.json`.

Dart and Flutter are unavailable on PATH. PowerShell/static validation passed; Dart compilation, formatting, analysis and runtime tests were not run. Structural checks do not independently prove factual accuracy or translation quality; the separately recorded primary-source and bilingual editorial review supplies that assessment.

Category 4 was not started.
