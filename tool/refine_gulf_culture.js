const fs=require('fs'),path=require('path');
const data=path.resolve(__dirname,'../content/gulf_culture');
const changes={
'029':['jassasiya:site:identity','jassasiya','ما الموقع الأثري القطري الذي يجمع نقوش القوارب والحفر الكأسية؟','Which Qatari archaeological site combines boat carvings and cup marks?','الجساسية','Al Jassasiya'],
'037':['bahrainpearling:houses:owners','bahrainpearling','بيوت أصحاب أي تجارة بحرية تشكل جزءاً من مسار اللؤلؤ في المحرق؟',"Houses belonging to merchants in which maritime trade form part of Muharraq's Pearling Path?",'تجارة اللؤلؤ','The pearl trade'],
'040':['mancala:game:pieces','mancala','بأي قطع صغيرة تُلعب المنقلة في نسخة لوحة متاحف قطر؟',"With what small pieces is mancala played in Qatar Museums' posted version?",'بالحصى أو الكرات الزجاجية','Stones or marbles'],
'042':['thuraya:name:stars','thuraya','ما نوع الجرم الفلكي الذي تحمل قبة الثريا القطرية اسمه؟',"What kind of astronomical object gives Qatar's Al Thuraya Planetarium its name?",'مجموعة نجوم','A star cluster'],
'066':['sesame:programme:identity','sesame','ما اسم البرنامج الخليجي التعليمي الشهير الذي تظهر شخصياته في عروض مسرحية للأطفال؟',"What is the famous Gulf educational programme whose characters appear in children's theatre shows?",'افتح يا سمسم','Iftah Ya Simsim'],
'079':['aali:workshops:archaeology','aali','بجوار أي نوع من المدافن الأثرية تقع ورش الفخار التقليدية في عالي؟',"Beside what type of ancient burial mounds are Aali's traditional pottery workshops?",'المدافن الملكية','Royal burial mounds'],
'134':['miadoha:site:island','miadoha','على أي نوع من الجزر بُني متحف الفن الإسلامي بالدوحة؟',"On what type of island was Doha's Museum of Islamic Art built?",'جزيرة اصطناعية أُنشئت خصيصاً له','A purpose-built artificial island'],
'136':['oldmuharraq:house:identity','oldmuharraq','أي بيت تاريخي في المحرق يضم أربعة أفنية وأبواباً خشبية منحوتة، وكان مسكناً لحاكم البحرين؟',"Which historic Muharraq house has four courtyards and carved wooden doors and was a Bahrain ruler's residence?",'بيت الشيخ عيسى بن علي','Shaikh Isa bin Ali House'],
'163':['gcc:poetry:firsthost','gccarts','أي عاصمة خليجية استضافت أول ملتقى للشعر لدول مجلس التعاون عام 1992؟','Which Gulf capital hosted the first GCC poetry gathering in 1992?','مسقط','Muscat']
};
for(const tier of ['easy','medium','hard']) {
 const file=path.join(data,tier+'.psv');const lines=fs.readFileSync(file,'utf8').trim().split(/\r?\n/).map(line=>{const id=line.split('|')[0];return changes[id]?[id,...changes[id]].join('|'):line;});
 fs.writeFileSync(file,lines.join('\n')+'\n');
}
