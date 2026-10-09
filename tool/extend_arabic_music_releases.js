const fs=require('fs');
const works=[
['hafla','حفلة','Hafla','نوال الزغبي','Nawal El Zoghbi','أحمد زعيم','Ahmed Zaeem','هاني صارو','Hany Sarou','https://www.filfan.com/videos/47936','FilFan release report, 20 July 2022: singer Nawal El Zoghbi; lyrics Hany Sarou; music Ahmed Zaeem; arrangement Amr El Khodary.'],
['yelaan','يلعن البعد','Yelaan El Boed','نجوى كرم','Najwa Karam','إيفان نصوح','Ivan Nassouh','إيلي بربر','Elie Barbar','https://gate.ahram.org.eg/News/4901532.aspx','Al Ahram 2024 release report: Najwa Karam; words and music Ivan Nassouh; arrangement Hady Sharara; mixing and mastering Elie Barbar.'],
['estimara','استمارة 6','Estimara 6','راغب علامة','Ragheb Alama','محمود الخيامي','Mahmoud El Khayamy','نادر عبدالله','Nader Abdallah','https://gate.ahram.org.eg/News/4544052.aspx','Al Ahram September 2023 report: Ragheb Alama sings; lyrics Nader Abdallah; music Mahmoud El Khayamy; arrangement Touma.'],
['sahsah','صح صح','Sah Sah','نانسي عجرم','Nancy Ajram','مودي سعيد','Moudi Saeed','أحمد علاء الدين','Ahmed Alaa El Din','https://www.filfan.com/news/148540','FilFan 8 July 2022 release: Nancy Ajram and Marshmello collaboration; lyrics Ahmed Alaa El Din; music Moudi Saeed; arrangement Tarek Madkour.'],
['walafi','ولا في الأحلام','Wala Fi El Ahlam','وائل جسار','Wael Jassar','أحمد زعيم','Ahmed Zaeem','أحمد قطوط','Ahmed Qatout','https://gate.ahram.org.eg/News/2572054.aspx','Al Ahram actual release 4 February 2021: Wael Jassar; lyrics Ahmed Qatout; music Ahmed Zaeem; arrangement Sherif Mansour. No speculative 2020 release date is used.'],
['matgheebsh','ما تغيبش ثواني','Ma Tgheebsh Sawani','وائل جسار','Wael Jassar','وليد سعد','Walid Saad','خالد تاج الدين','Khaled Tag El Din','https://www.youm7.com/story/2020/7/26/وائل-جسار-يختص-اليوم-السابع-بكلمات-أغنيته-ولا-فى-الأحلام/4898809','Youm7 26 July 2020 artist report explicitly identifies the earlier release: lyrics Khaled Tag El Din; music Walid Saad; arrangement Walid Sheraqy. Only credits, not projected release dates, are used.'],
['kon','كون','Kon','جوزيف عطية','Joseph Attieh','جمال ياسين ورامي شلهوب','Jamal Yassine and Rami Chalhoub','سامي بساط','Sami Bsat','https://www.filfan.com/videos/48332','FilFan release report 25 February 2023: Joseph Attieh; lyrics Rami Chalhoub; co-composers Jamal Yassine and Rami Chalhoub; video director Sami Bsat. Corroborated Al Masry Al Youm 2896697. Excludes erroneous Star Academy chronology in another biography.'],
['baghdada','البغددة','Al Baghdada','جوزيف عطية','Joseph Attieh','عزيز الشافعي','Aziz El Shafie','وسام عبدالمنعم','Wissam Abdel Moneim','https://www.almasryalyoum.com/news/details/2896697','Al Masry Al Youm release announcement 27 May 2023: Joseph Attieh; words and music Aziz El Shafie; arrangement Wissam Abdel Moneim.'],
['motallaqa','المطلقة','El Motallaqa','كارول سماحة','Carole Samaha','ميشيل فاضل','Michel Fadel','علي المولى','Ali Al Mawla','https://www.filfan.com/news/detailsamp/98674','FilFan 2019 release report: Carole Samaha performs; words Ali Al Mawla; music and arrangement Michel Fadel. No lyrics reproduced.'],
['habibiduo','حبيبي','Habibi','عاصي الحلاني والوليد الحلاني','Assi El Hallani and Al Walid El Hallani','عادل العراقي','Adel Al Iraqi','نزار فرنسيس','Nizar Francis','https://www.youm7.com/story/2021/7/6/شاهد-صورة-نادرة-لـلنجمة-الراحلة-صباح-مع-عاصى-الحلانى/5379928','Youm7 6 July 2021 report: duet Assi and Al Walid El Hallani; lyrics Nizar Francis; music Adel Al Iraqi; arrangement Tony Saba.'],
['maswloli','ماس ولولي','Mas Wloli','ديانا حداد والشاب خالد','Diana Haddad and Khaled','محمد يحيى','Mohammed Yehia','أحمد مرزوق','Ahmed Marzouk','https://www.filfan.com/news/2414','FilFan first-person lyricist interview 21 February 2006: Ahmed Marzouk identifies his lyrics, composer Mohammed Yehia, arranger Medhat Khamis and the Diana Haddad/Khaled duet.']
];
const tiers={easy:[],medium:[],hard:[]};let e=47,m=114,h=182;
const line=(id,key,src,ar,en,aa,ae)=>[String(id).padStart(3,'0'),key,src,ar,en,aa,ae].join('|');
for(const [key,title,en,singer,se,comp,ce,writer,we,url,evidence] of works){
 let qa=`من صاحب أغنية «${title}»؟`,qe=`Who performs ${en}?`;
 if(key==='yelaan'){qa='من المطربة التي أصدرت «يلعن البعد» عام 2024؟';qe='Which singer released Yelaan El Boed in 2024?';}
 if(key==='sahsah'){qa='أي مطربة لبنانية شاركت مارشميلو في أغنية «صح صح»؟';qe='Which Lebanese singer collaborated with Marshmello on Sah Sah?';}
 if(key==='habibiduo'){qa='من الثنائي الذي غنّى «حبيبي» في إصدار عام 2021؟';qe='Which duo performed the 2021 release of Habibi?';}
 if(key==='maswloli'){qa='من الثنائي الذي قدّم أغنية «ماس ولولي»؟';qe='Which duo performed Mas Wloli?';}
 tiers.easy.push(line(e++,`song:${key}:singer`,key,qa,qe,singer,se));
 let ma=`من لحّن أغنية ${singer} «${title}»؟`,me=`Who composed ${singer=== 'ديانا حداد والشاب خالد'?'the Diana Haddad and Khaled duet':se+"'s"} ${en}?`;
 if(['yelaan','baghdada'].includes(key)){ma=`من كتب ولحّن أغنية «${title}» لـ${singer}؟`;me=`Who wrote both the lyrics and music for ${se}'s ${en}?`;}
 if(key==='kon'){ma='من الملحنان اللذان اشتركا في تلحين «كون» لجوزيف عطية؟';me='Which two composers jointly composed Joseph Attieh\'s Kon?';}
 tiers.medium.push(line(m++,`song:${key}:composer`,key,ma,me,comp,ce));
 let ha=`من كتب كلمات أغنية ${singer} «${title}»؟`,he=`Who wrote the lyrics for ${se}'s ${en}?`,role='lyricist';
 if(key==='yelaan'){ha='من تولّى المكس والماستر لأغنية نجوى كرم «يلعن البعد» عام 2024؟';he='Who handled mixing and mastering for Najwa Karam\'s 2024 Yelaan El Boed?';role='mixmaster';}
 if(key==='kon'){ha='من أخرج فيديو كليب «كون» لجوزيف عطية؟';he='Who directed the music video for Joseph Attieh\'s Kon?';role='videodirector';}
 if(key==='baghdada'){ha='من وزّع أغنية جوزيف عطية «البغددة» موسيقياً؟';he='Who arranged Joseph Attieh\'s Al Baghdada?';role='arranger';}
 tiers.hard.push(line(h++,`song:${key}:${role}`,key,ha,he,writer,we));
 fs.appendFileSync('content/arabic_music/sources.psv',`${key}|Release credit evidence — ${en}|${url}|Retrieved or indexed 2026-10-08. ${evidence}\n`);
}
for(const [tier,rows]of Object.entries(tiers))fs.appendFileSync(`content/arabic_music/${tier}.psv`,rows.join('\n')+'\n');
console.log(JSON.stringify({added:33,next:{e,m,h}}));
