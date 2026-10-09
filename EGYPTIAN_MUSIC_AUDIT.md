# Egyptian Music audit — 2026-10-08

| Category | Total | easy200 | medium400 | hard600 | Duplicates | Unresolved near-duplicates | Missing sources | Missing translations | Status |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Egyptian Music / أغاني مصرية | 204 | 68 | 68 | 68 | 0 | 0 | 0 | 0 | COMPLETE — static and assistant editorial review |

204 original bilingual questions are stored in six Dart files of 34 questions each. The evidence ledger uses 71 source entries: official artist and recording-label descriptions, Ministry of Culture releases, State Information Service biographies, Cultural Development Fund museum/venue pages, cultural-authority programmes, music publishers, established press and first-person interviews. No song lyrics were reproduced.

All 204 Arabic/English prompts and answers were inspected by the assistant. Easy questions emphasize recognizable songs, performers, prominent nicknames and an accessible theatre format. Medium questions cover composers, albums, institutions, instruments, film appearances and familiar poetry. Hard questions cover less familiar writers, production/engineering credits, historical ensembles, puppet design and musical-history details. Nizar Qabbani's familiar poetry attribution was moved to medium; Abdel Halim's exact birth village is hard. The bank covers 79 semantic groups. Composer, writer, performer and engineer are different credited roles, including cases where one artist holds two roles. No inverse question about the same identity was retained.

The overlap review inspected 93 internal candidates, the distinct protected facts underlying 625 cross-bank wording flags, and all 32 shared-answer candidates against the 19 previously completed banks. These counts describe flags, not unresolved duplicates. All requested relations were distinct; decisions are hash-bound. Examples include an album called Roma versus the football club; Mohammed Abdel Wahab's Egyptian song credits versus his work with Talal Maddah; and Umm Kulthum recordings versus her influence on Awadh Doukhi. Protected Boshret Kheir credits were excluded. Maximum English token similarity is 0.818.

Research corrections: Betwanes Beek's writer is Omar Batisha; We Malo's writer is Khaled Tag El Din. El Zein Wel Zeina uses a Libyan traditional melody according to Ali El Haggar; its arranger is not asserted to be its original composer. Conflicting Amal Hayati composer metadata and malformed maqam metadata were excluded. Tetraga Feya's unverified composer attribution was excluded. Upload dates were not substituted for original release dates. Cairokee member roles are tied to the credited 2017 session. Warda and Fayza Ahmed are included for their established Egyptian repertoire without falsely describing their nationality.

Full static validation passed: no duplicate IDs, normalized Arabic/English questions or fact keys; no missing prompts, answers, translations or sources; no wrong category IDs or invalid point mapping; no unresolved editorial, semantic-family, internal, cross-bank or shared-answer reviews; and no changed protected-file hashes. Existing UI and gameplay were preserved; only the category's bank import and playable registration were appended.

Passed commands:

```powershell
pwsh -NoProfile -File tool/generate_egyptian_music.ps1
node tool/egyptian_music_similarity.js egyptian_music --save
node tool/egyptian_music_shared_answers.js --save
node tool/record_egyptian_music_editorial_review.js
pwsh -NoProfile -File tool/validate_egyptian_music.ps1 -WriteCandidates -WriteReport
```

Validation checks evidence mapping and URL syntax; it does not prove factual truth merely by checking a URL. The evidence ledger records retrieved versus indexed descriptions, including official video credits where direct retrieval was unavailable. Editorial and semantic review were performed by the assistant, not an independent human reviewer, and automated scanning cannot guarantee exhaustive detection. Dart/Flutter were unavailable, so executable Dart tests, formatting and analysis could not run. PowerShell/Node static checks supplied the available validation.

The certified library contains 20 categories and 4,080 questions. Seven of the current ten-category batch are complete, totalling 1,428 questions. Arabic Music follows next; the final batch audit remains pending until Arabic Music, International Music and Old School Music pass.
