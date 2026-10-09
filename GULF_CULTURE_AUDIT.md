# Gulf Culture — category 4

Completed 2026-10-07 with 204 original bilingual questions: 68 easy200, 68 medium400, 68 hard600. The six active Dart batches contain 34 questions each and are imported by the bank catalog and playable category registry.

The evidence ledger maps each question to a verified primary source and a factual evidence note. Sixty-five source entries are used, including UNESCO, GCC Secretariat, national cultural authorities, national libraries, museums, official tourism organizations, literary prize organizers and government news agencies. Unsupported folklore, medical claims, contradictory construction dates and outdated numerical statistics were excluded.

Editorial review covers all 204 Arabic/English question and answer pairs. Seventy semantic families distinguish genuinely different attributes from reworded facts. The generic aflaj irrigation-purpose question was removed because it repeated UAE Heritage. Giveaway binary prompts were rewritten, and the specialist Qatari game names moved to 600. Difficulty uses common regional knowledge at 200, more specific cultural recognition at 400, and specialist traditions, terminology and historical detail at 600.

The bilingual lexical scan found zero internal candidates at Jaccard 0.60. Its maximum English similarity was 0.571. Two cross-bank candidates at 0.50 were manually resolved: Omani dishdasha versus Emirati kandura, and Omani mussar identity versus Emirati agal function. Different regional garments and functions are distinct facts. Both decisions bind to the compared content hashes. UAE Heritage's poetry setting, length and poet questions differ from this bank's multinational nomination and dispute-resolution questions.

`pwsh -NoProfile -File tool/validate_gulf_culture.ps1 -WriteReport` passed: total 204; 68/68/68; zero duplicate IDs, Arabic prompts, English prompts or fact keys; zero missing sources, questions, answers or translations; zero wrong category IDs; zero unresolved editorial, family, internal or cross-bank reviews. Dart content matches its reviewed editorial rows and official source mapping. Every protected UAE Football, UAE and UAE Heritage file matches the batch baseline SHA-256.

The picker and board now use the same playable registry, preserving the first seven legacy indexes and picture modes. The displayed count reads the selected bank's actual length. Board slots remain 200/200/400/400/600/600 with the existing 60-second main and 15-second steal timers and manual award flow. Changes are limited to data wiring and the count label. Flutter/Dart were unavailable, so runtime compilation and UI execution remain unverified; PowerShell/static checks were used.

Evidence: `content/gulf_culture/evidence_ledger.csv`; question review: `editorial_review.csv`; semantic decisions: `fact_family_review.csv` and `cross_bank_review.csv`; machine results: `validation_result.json`. Source-linked factual review is separate from structural validation.
