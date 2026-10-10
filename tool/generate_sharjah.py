#!/usr/bin/env python3
"""Import the user-provided Sharjah 300-question workbook without changing its Arabic content."""
import json, time, urllib.parse, urllib.request
from pathlib import Path
from openpyxl import load_workbook

root=Path(__file__).resolve().parents[1]
source=root/'tool/imports/‎⁨إمارة الشارقة _300⁩.xlsx'
if not source.exists():
    raise FileNotFoundError('Uploaded Sharjah workbook not found in tool/imports/')
sheet=load_workbook(source,read_only=True,data_only=True)['بنك الأسئلة']
rows=list(sheet.iter_rows(min_row=2,max_col=6,values_only=True))
assert len(rows)==300, f'Expected 300 questions, found {len(rows)}'
assert sorted(int(r[0]) for r in rows)==list(range(1,301)), 'Missing or duplicate question IDs'
assert {p:sum(r[2]==p for r in rows) for p in (200,400,600)}=={200:100,400:100,600:100}
assert all(r[3] and r[4] for r in rows)
cache_file=root/'tool/imports/sharjah_en_cache.json'
cache=json.loads(cache_file.read_text()) if cache_file.exists() else {}
def translate(s):
    params=urllib.parse.urlencode({'client':'gtx','sl':'ar','tl':'en','dt':'t','q':str(s)})
    for retry in range(6):
        try:
            req=urllib.request.Request('https://translate.googleapis.com/translate_a/single?'+params,headers={'User-Agent':'Mozilla/5.0'})
            with urllib.request.urlopen(req,timeout=35) as response:
                result=json.load(response)
            translation=''.join(chunk[0] for chunk in result[0] if chunk[0]).strip()
            if translation:return translation
        except Exception:time.sleep(min(2**retry,20))
    raise RuntimeError('Translation failed for: '+str(s)[:60])
def quote(s):
    return "'"+str(s).replace('\\','\\\\').replace("'","\\'").replace('$','\\$').replace('\n',' ')+"'"
out=["import '../question_model.dart';","","// Arabic text is preserved verbatim from the uploaded workbook.","// English is machine translated and requires human editorial review.","final sharjahQuestions = <TriviaQuestion>["]
for num,level,points,question,answer,topic in rows:
    key=str(num)
    if key not in cache:
        cache[key]={'q':translate(question),'a':translate(answer)}
        if num%10==0:cache_file.write_text(json.dumps(cache,ensure_ascii=False,indent=2))
    en=cache[key]
    args=['id:'+quote('SHJ'+str(num).zfill(3)),"categoryId:'sharjah'",
          'difficulty:QuestionDifficulty.'+{200:'easy200',400:'medium400',600:'hard600'}[points],
          'questionAr:'+quote(question),'questionEn:'+quote(en['q']),
          'answerAr:'+quote(answer),'answerEn:'+quote(en['a']),
          "sourceName:'User-provided Sharjah workbook (not independently fact-checked)'",
          "sourceUrl:'https://www.sharjah.ae/'",
          'lastVerified:DateTime(2026,10,11)',
          'factKey:'+quote('sharjah:'+key)]
    out.append('  TriviaQuestion('+','.join(args)+'),')
cache_file.write_text(json.dumps(cache,ensure_ascii=False,indent=2))
out.append('];')
dest=root/'lib/data/questions/sharjah_questions.dart'
dest.write_text('\n'.join(out)+'\n')
assert dest.read_text().count('TriviaQuestion(')==300
print('Generated 300 bilingual Sharjah questions')
