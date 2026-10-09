# Arabic Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Arabic Music / أغاني عربية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

204 original bilingual questions are stored in six Dart files, 34 each. The question-level evidence ledger uses 87 source entries from official artist channels, record labels, university archives, UNESCO, a heritage NGO network, the Baalbeck festival organizer, the INA television archive, established press and first-person interviews. No song lyrics were reproduced. The bank includes Levantine pop, Iraqi repertoire and maqam, Tunisian music, Algerian rai, Moroccan groups, Sudanese repertoire, Mauritanian traditions and contemporary instrumental music.

The assistant inspected all Arabic and English questions and answers. Easy emphasizes performer recognition, familiar identities and country associations. Medium covers composers, albums, institutions and heritage terms. Hard covers less familiar writers, arrangers, instrumentalists, production and historical details. The exact release year of Le pas du chat noir and ISSAM's debut album belong at hard; the familiar poet of Ana Wa Leila, the coiner of Fairuz's nickname and Baalbeck's postwar resumption belong at medium. The 2019 ECM reissue is not confused with the 2002 original release.

The review covers 97 semantic groups, all 55 internal flags, the distinct protected facts underlying 494 cross-bank wording flags, and all 37 shared-answer comparisons against 20 completed banks. These are candidate counts, not duplicates. Separate named recordings or credited roles remain distinct; no inverse question about one credited identity is retained. Examples include Nizar Qabbani's Kalimat versus Resala Men Taht El Maa; Amr Mostafa's Youm Wara Youm versus Boshret Kheir; and Anouar Brahem's oud versus other musicians' instrument credits. All decisions are bound to hashes of reviewed content. Maximum English token similarity is 0.846.

Unsupported remembered song credits were excluded. Yelaan El Boed's 2024 words and music are credited to Ivan Nassouh. Nancy Ajram's Inta Eih uses Samir Sfeir's music and Mostafa Morsi's words. Nassam Alayna El Hawa's duo composition is distinct from Saalouny El Nas's Ziad Rahbani credit. Hiba Tawaji's La Bidayi Wala Nihayi retains the international melody source, Mansour Rahbani's Arabic words and Oussama Rahbani's adaptation/orchestration as different roles. Ambiguous Ayshalak composition metadata and incorrect Joseph Attieh biography chronology were excluded. The actual 2021 Wala Fi El Ahlam release report supersedes a 2020 planned release. Video uploads and compilation copyrights are not treated as original song release dates.

Passed commands:

```powershell
pwsh -NoProfile -File tool/generate_arabic_music.ps1
node tool/arabic_music_similarity.js arabic_music --save
node tool/arabic_music_shared_answers.js --save
node tool/record_arabic_music_editorial_review.js
pwsh -NoProfile -File tool/validate_arabic_music.ps1 -WriteCandidates -WriteReport
```

Full static validation returned zero duplicate IDs, normalized Arabic/English prompts and fact keys; missing prompts, answers, translations and source mappings; wrong category IDs; invalid difficulty/point mappings and URL syntax; unresolved editorial, fact-family, internal, cross-bank and shared-answer reviews; and changed protected-file hashes. Only this bank's import and playable registration were appended to the shared catalog files. UI and gameplay were preserved.

URL syntax and evidence mapping do not independently prove a claim. Research records distinguish retrieved pages from indexed official descriptions, including video credits whose direct retrieval was unavailable. Review was performed by the assistant, not an independent human editor; automated semantic scanning cannot guarantee exhaustive detection. Dart/Flutter were unavailable, so Dart formatting, analysis and executable tests could not run. PowerShell and Node supplied static validation.

The certified library now contains 21 categories and 4,284 questions. Eight of the current ten-category batch are complete. International Music and Old School Music remain unfinished; the final ten-category audit is pending.
