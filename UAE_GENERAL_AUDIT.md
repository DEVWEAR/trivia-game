# Category 2 — الإمارات / UAE

COMPLETE — 2026-10-07. Category ID: `uae_general`.

The active repository bank contains 204 independently phrased bilingual questions: 68 easy200, 68 medium400 and 68 hard600. The existing `uaeGeneralFinalQuestions` export now imports six explicit 34-question batches. The four superseded, unreferenced legacy UAE question files were removed. UI, gameplay, scoring and timers were not edited. Category 3 was not started.

## Validation

PowerShell/static validation passed against the actual imported Dart definitions, with an exact comparison to every editorial row and its source registry entry:

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
| Changed protected UAE Football files | 0 |

The validator checks six imports and spreads, 204 globally unique new IDs, question/answer text parity between PSV and Dart, difficulty, HTTPS URLs, evidence mappings and verification dates. It also compares the SHA-256 preservation manifest for the completed football bank and its editorial/validation files.

Run `./tool/validate_uae_general.ps1 -WriteReport` to reproduce the report and evidence ledger. Run `./tool/generate_uae_general.ps1` after editing the PSV. New or changed similarity candidates require individual editorial decisions; the validator does not approve them automatically.

## Sources and editorial review

All 204 questions have Arabic and English prompts and answers, a source name and real source URL, a canonical fact key, and verification date 2026-10-07. The bank uses 93 source entries. Research prioritised UAE government, the National Library and Archives, Central Bank, official tourism authorities, UNESCO, MBRSC, NASA, universities, operators, architects, cultural organisers and international sports federations. First-person creators' biographies and an author interview support specialist arts questions. `content/uae_general/evidence_ledger.csv` maps every answer to its evidence summary and URL.

The complete prompts and answers were reviewed for the same requested fact in both languages, natural Arabic, unambiguous scope and meaningful difficulty. Easy questions emphasise familiar national identity and recognisable places or people; medium questions require local knowledge of milestones, cultural works, institutions and infrastructure; hard questions cover specialist history, archaeology, scientific instruments, architecture and literary or sporting achievements. Difficulty is an editorial judgement, not a measured player success rate.

Corrections during review included removing the answer from the anthem prompt, replacing a repeated first-Olympic-gold event, replacing the self-revealing Palm Jumeirah shape question, moving specialised dates and tribal history to hard600, and replacing a questionable peninsula transliteration. Conflicting dates for Al Bidya Mosque construction were excluded. The disputed publication year of *Plank of Wood* was removed from its author question. The contemporary UNESCO status of UAE Al Sadu was checked: original Urgent Safeguarding inscription in 2011 and transfer to the Representative List in 2025.

## Duplicate and fact review

The all-pairs scan compares normalized English and Arabic token sets at a 0.60 threshold and detects repeated answers within a subject family. Five candidate pairs were individually reviewed and recorded with content fingerprints in `near_duplicate_review.csv`: first President versus first Vice President; largest versus smallest emirate; anthem versus national tree; airport inauguration versus Terminal 3 inauguration; and architects of two different museums. Their different facts and answers are documented individually. None is a rewording or reversal of the same fact. Maximum English overlap is 0.778, below the existing Dart validator's 0.85 threshold.

The entire bank was also reviewed by canonical subject and across differently named subject families. `fact_family_review.csv` records the 47 multi-question families and their separate facts. In particular, the first Olympic gold discipline question was replaced, while a later world championship location remains a separate competition. Repeated people or landmarks ask separate attributes rather than supplying the reverse side of an earlier question. Family review covers distinct astronomy mission destinations/instruments, different heritage sites and periods, separate Expo themes/pavilions, hospital founders, cultural authors, and institution milestones. No unresolved duplicate or near-duplicate fact was identified.

Coverage includes all seven emirates, national history and identity, geography, traditional crafts, archaeology, literature, cinema, contemporary art, education, healthcare history, transport, energy, space science, environment, major events and sport beyond football.

## Environment

Dart and Flutter were unavailable on PATH. PowerShell static validation was used as requested. Flutter compilation, formatting, analysis and runtime tests were not executed; static checks do not constitute a Flutter build. Source accuracy and bilingual equivalence were editorially reviewed separately from structural validation.
