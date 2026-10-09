const fs = require('fs');
const dir = 'content/kuwait_general/';
const sources = [
['school','Kuwait Government Online — Mubarakiya School history','https://e.gov.kw/sites/kgoarabic/Pages/ApplicationPages/NewsDetail.aspx?nid=1011741','First formal school Mubarakiya opened22December1911; named SheikhMubarak; advocatesYusufAlQinai,NasserAlMubarak,YasinAlTabtabai; original religion Arabic arithmetic Islamic history; later Palestinian teachers.'],
['shadi','Al Wasat — Kuwaiti Artists Society meeting report','https://www.alwasat.com.kw/ArticleDetail.aspx?id=151152','Firsthand meeting report names singer AbdulazizAlMufarrej as ShadiAlKhaleej.'],
['arabi','Al Jarida — Firsthand recollections of Al Arabi founder','https://www.aljarida.com/articles/1543941311656213400','BaderKhaledAlBader recalls first issue1December1958 GovernmentPrintingPress; name publiccompetition; firsteditor Egyptian DrAhmedZaki.'],
['kfas','Kuwait Foundation for the Advancement of Sciences — Who We Are','https://www.kfas.org/Organization/Who-We-Are','Private nonprofit foundedDecember1976; science research innovation awareness specializedcentres prizes KuwaitiArabresearchers.'],
['kfasfunding','KFAS — Research Portal','https://research.kfas.org.kw/ar/','Private nonprofit1976 fundedprivateKuwaiti shareholdingcompanies annualnetprofitcontributions1percent.'],
['kisrhistory','KISR — Three Decades and Beyond of Strategic Planning','https://nstic.kisr.edu.kw/wp-content/uploads/2024/05/3-Three-Decades-and-Beyond-of-Strategic-Planning-Mar2021.pdf','KISR established1967 JapanArabOilCompany offsetagreement; initialpetroleum agriculture fisheriesresearch.'],
['fund','Kuwait Fund for Arab Economic Development — Timeline','https://www.kuwait-fund.org/ar/web/kfund/timeline','FoundedDecember1961; firstloan1962Sudanrailways; 1964EgyptSuezCanaldevelopment; 1975TunisiaTunisCarthageairport.'],
['humanitarian','United Nations — Humanitarian recognition remarks','https://press.un.org/en/2014/sgsm16132.doc.htm','9September2014 BanKiMoon honours Kuwait AmirSabahAlAhmad humanitarianleadership; Kuwaithosted Syria pledgingconferences2013and2014.'],
['humanitariancentre','UNDP Kuwait — Humanitarian recognition anniversary','https://www.undp.org/kuwait/speeches/anniversary-naming-kuwait-former-secretary-general-united-nations-ban-ki-moon-humanitarian-center-and-late-emir-sabah-al-ahmad-al','Kuwait HumanitarianCenter and AmirSabahAlAhmad humanitarianleader designation9September2014.'],
['sabiliat','International Prize for Arabic Fiction — Al Sabiliat','https://archive.arabicfiction.org/en/Al-Sabiliat','Kuwaiti authorIsmailFahdIsmail novelAlSabiliat IraqIranwar.'],
['sabiliatevents','International Prize for Arabic Fiction — 2017 Events','https://archive.arabicfiction.org/en/2017events','2017shortlistedAlSabiliat authorIsmailFahdIsmail protagonistUmKassem.'],
['talal','ISSF — Talal Alrashidi Junior World Champion','https://www.issf-sports.org/news/1544','TalalAlrashidi2011JuniorTrapWorldChampionBelgradeKovilovo sonofAbdullahAlrashidi skeetworldchampion.']
];
fs.appendFileSync(dir+'sources.psv',sources.map(x=>x.join('|')).join('\n')+'\n');
function replace(file,id,row){const lines=fs.readFileSync(dir+file,'utf8').trim().split(/\r?\n/);const i=lines.findIndex(x=>x.startsWith(id+'|'));if(i<0)throw Error(id);lines[i]=row;fs.writeFileSync(dir+file,lines.join('\n')+'\n');}
replace('easy.psv','027','027|education:mubarakiya:identity|school|ما اسم أول مدرسة نظامية افتُتحت في الكويت عام 1911؟|What was Kuwait\'s first formal school, opened in 1911, called?|المدرسة المباركية|Al-Mubarakiya School');
replace('easy.psv','055','055|governorate:jahra:largest|topography|ما أكبر محافظات الكويت مساحةً؟|Which Kuwaiti governorate is largest by area?|الجهراء|Jahra');
replace('easy.psv','058','058|press:arabi:identity|arabi|ما المجلة الثقافية الكويتية التي صدر عددها الأول في ديسمبر 1958؟|Which Kuwaiti cultural magazine published its first issue in December 1958?|العربي|Al-Arabi');
replace('easy.psv','061','061|music:shadi:stagename|shadi|ما الاسم الفني للمطرب الكويتي عبدالعزيز المفرج؟|What is Kuwaiti singer Abdulaziz Al-Mufarrej\'s stage name?|شادي الخليج|Shadi Al-Khaleej');
replace('medium.psv','116','116|humanitarian:recognition:amir|humanitarian|أي أمير كويتي كرّمته الأمم المتحدة عام 2014 لقيادته الإنسانية؟|Which Kuwaiti Amir did the United Nations honour in 2014 for humanitarian leadership?|الشيخ صباح الأحمد الجابر الصباح|Sheikh Sabah Al-Ahmad Al-Jaber Al-Sabah');
replace('medium.psv','124','124|literature:sabiliat:author|sabiliat|من مؤلف رواية «السبيليات»؟|Who wrote the novel Al-Sabiliat?|إسماعيل فهد إسماعيل|Ismail Fahd Ismail');
replace('medium.psv','129','129|press:arabi:firsteditor|arabi|من أول رئيس تحرير لمجلة «العربي» الكويتية؟|Who was the first editor-in-chief of Kuwait\'s Al-Arabi magazine?|الدكتور أحمد زكي|Dr Ahmad Zaki');
replace('medium.psv','132','132|aid:fund:firstborrower|fund|أي دولة حصلت على أول قرض من الصندوق الكويتي للتنمية عام 1962؟|Which country received the Kuwait Fund\'s first loan in 1962?|السودان|Sudan');
console.log('Draft substitutions applied; source rows added. Editorial validation remains pending.');
