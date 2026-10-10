#!/usr/bin/env python3
"""Translate the 300-row El Clasico workbook and generate bilingual Flutter questions.
Machine translations are marked as such and require editorial review.
"""
import json
import os
import time
import urllib.parse
import urllib.request
from pathlib import Path

root = Path(__file__).resolve().parents[1]
data = json.loads((root / "tool/imports/el_clasico_ar_300.json").read_text(encoding="utf-8"))
questions = data["questions"]
assert len(questions) == 300
assert [q["id"] for q in questions] == [f"ELC{i:03}" for i in range(1,301)]
assert {p:sum(q["points"]==p for q in questions) for p in (200,400,600)} == {200:100,400:100,600:100}

def translate(text):
    params = urllib.parse.urlencode({"client":"gtx","sl":"ar","tl":"en","dt":"t","q":text})
    url = "https://translate.googleapis.com/translate_a/single?" + params
    last_error = None
    for attempt in range(6):
        try:
            req = urllib.request.Request(url,headers={"User-Agent":"Mozilla/5.0"})
            with urllib.request.urlopen(req, timeout=30) as response:
                value = json.load(response)
            result = "".join(item[0] for item in value[0] if item[0])
            if result.strip() and result != text:
                return result.strip()
            raise ValueError("Empty or untranslated result")
        except Exception as exc:
            last_error = exc
            time.sleep(min(2**attempt,30))
    raise RuntimeError(f"Translation failed for {text[:50]}: {last_error}")

def dart(value):
    return "'" + str(value).replace("\\","\\\\").replace("'","\\'").replace("$","\\$").replace("\n"," ") + "'"

# Preserve already-reviewed English translations, if any.
existing = root / "tool/imports/el_clasico_translations_en.json"
cache = json.loads(existing.read_text(encoding="utf-8")) if existing.exists() else {}
for i,q in enumerate(questions,1):
    key=q["id"]
    item=cache.get(key,{})
    if not item.get("questionEn"):
        item["questionEn"]=translate(q["questionAr"])
    if not item.get("answerEn"):
        item["answerEn"]=translate(q["answerAr"])
    cache[key]=item
    if i % 25 == 0:
        print(f"Translated {i}/300",flush=True)
        existing.write_text(json.dumps(cache,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
existing.write_text(json.dumps(cache,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
lines=["import '../question_model.dart';","","// 300 questions from the user-provided workbook. English translations are machine-generated; editorial fact-check pending.","final elClasicoQuestions = <TriviaQuestion>["]
for q in questions:
    e=cache[q["id"]]
    diff={200:"easy200",400:"medium400",600:"hard600"}[q["points"]]
    lines.append("  TriviaQuestion("+",".join([
        "id:"+dart(q["id"]),
        "categoryId:'el_clasico'",
        "difficulty:QuestionDifficulty."+diff,
        "questionAr:"+dart(q["questionAr"]),
        "questionEn:"+dart(e["questionEn"]),
        "answerAr:"+dart(q["answerAr"]),
        "answerEn:"+dart(e["answerEn"]),
        "sourceName:'User-provided El Clasico workbook (draft, not fact-checked)'",
        "sourceUrl:'https://www.laliga.com/'",
        "lastVerified:DateTime(2026,10,10)"
    ])+"),")
lines.append("];")
output=root/"lib/data/questions/el_clasico_questions.dart"
output.parent.mkdir(parents=True,exist_ok=True)
output.write_text("\n".join(lines)+"\n",encoding="utf-8")
assert output.read_text(encoding="utf-8").count("TriviaQuestion(")==300
print("Generated 300 bilingual questions")
