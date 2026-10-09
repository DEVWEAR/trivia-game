const fs=require('fs');
const sources=[
['saken','Diana Haddad official licensed recording','https://www.youtube.com/watch?v=0WCbM33yI00','Artist recording identifies Diana Haddad and Saken. Copyright year is not used as the original release year.'],
['wanimarek','Assi El Hallani official licensed recording','https://www.youtube.com/watch?v=8sgPJ3SDQy4','Official artist channel recording identifies Assi and Wani Marek Marreyt. No guessed author credits used.'],
['shami','Al Shami official recording','https://www.youtube.com/watch?v=b3unvqHR9m8','Official 2023 music video identifies Al Shami and Ya Leil W Yal Ein.'],
['siilawy','Siilawy official recording','https://www.youtube.com/watch?v=c8C04rOeFvI','Official artist music video identifies Siilawy and Aashanak.'],
['wbtir','Ziad Bourji official music video','https://www.youtube.com/watch?v=lMGHr5LSkYM','Artist video identifies Ziad Bourji and W Btir. No inferred disputed credits used.'],
['howeh','Adham Nabulsi recording on Spotify','https://open.spotify.com/intl-ar/track/61BY3UOTFlaFCmFVJI6N3f','Catalog identifies Howeh El Hob and Adham Nabulsi.'],
['fairuznickname','Lebanese Army Magazine — Fairuz cultural history','https://magazine.lebarmy.gov.lb/pages/فـيروز/','Author Akram Al Rayess identifies Fairuz as Safiratuna Ila Al Nojoum and attributes the title to Said Akl in 1956. No lyrics reproduced.'],
['dhaferbio','Dhafer Youssef official biography','https://dhaferyoussef.com/biography-part-1/','Artist biography explicitly identifies him as Tunisian. Film-score authorship language appears imprecise and is excluded.'],
['cestlavie','Khaled official music video','https://www.youtube.com/watch?v=5dWeeUIZFgA','Artist music video identifies Khaled and Cest La Vie. No unverified producer attribution used.'],
['issam','Universal Music France — ISSAM biography','https://universalmusic.fr/artistes/32780008340','Primary label identifies Hasni as homage to Cheb Hasni; first studio album Crystal in 2021; participation in Naar collective.'],
['faudel','Universal Music France — Faudel biography','https://www.universalmusic.fr/artistes/20000286139','Primary label identifies Tellement Nbrick and debut album Baida. No conflicting original release year used.'],
['soleils','INA television archive — 1 2 3 Soleils','https://www.ina.fr/ina-eclaire-actu/video/cab98039334/1-2-3-soleils-concert-rai-a-bercy','Contemporaneous France 2 news 26 September 1998: Khaled, Rachid Taha and Faudel at Bercy.'],
['rita','ECM Records — The Astounding Eyes Of Rita','https://ecmrecords.com/product/the-astounding-eyes-of-rita-anouar-brahem/','Primary album notes: dedicated to Mahmoud Darwish; Klaus Gesing bass clarinet; Khaled Yassine darbouka and bendir.'],
['baalbeknights','AUB Libraries — Lebanese Nights archive exhibit','https://online-exhibit.aub.edu.lb/exhibits/show/baalbeck--seventy-years-of-lig/baalbeck--a-stage-for-the-worl/lebanese-nights--al-layali-lub','Baalbeck festival archives and AUB university library identify the Lebanese Nights beginning in 1957.'],
['baalbekhistory','Baalbeck International Festival — History','https://www.baalbeck.org.lb/history/','Organizer identifies creation in 1956; activities suspended 1975–1996 and resumed 1997.'],
['fairuzopening','Lebanese Army — Fairuz and the Lebanese Nights','https://www.lebarmy.gov.lb/ar/content/فـيروز-دبلوماسية-الصوت-والحكايا','Researcher identifies Fairuz opening the 31 August and 1 September 1957 Baalbeck evenings with Lebnan Ya Akhdar Helou.'],
['carte','Universal Music France — Carte de Sejour','https://www.universalmusic.fr/artistes/20000068610','Primary label: Douce France on 2 et demi, produced Nick Patrick; Rhorhomanie produced Steve Hillage.'],
['gnawaterms','ICH NGO Forum — Voices of Essaouira','https://ichngo.net/network_detail/?category=&id=300&subject=INVENTORIES','Heritage NGO network identifies master musician maallem leading Gnawa and qraqeb as metallic castanets.'],
['lepas','ECM Records — Le pas du chat noir','https://ecmrecords.com/product/le-pas-du-chat-noir-anouar-brahem/','Primary album credits: original release 9 September 2002, distinct from 2019 reissue; Francois Couturier piano and Jean-Louis Matinier accordion.']
];
for(const [key,title,url,evidence]of sources)fs.appendFileSync('content/arabic_music/sources.psv',[key,title,url,'Retrieved or indexed 2026-10-08. '+evidence].join('|')+'\n');
const easy=`058|song:saken:singer|saken|من المطربة صاحبة أغنية «ساكن»؟|Which singer performs Saken?|ديانا حداد|Diana Haddad
059|song:wanimarek:singer|wanimarek|من غنّى «وآني مارق مريت»؟|Who sings Wani Marek Marreyt?|عاصي الحلاني|Assi El Hallani
060|song:yaleilyalein:singer|shami|من المطرب السوري صاحب أغنية «يا ليل ويا العين»؟|Which Syrian singer performs Ya Leil W Yal Ein?|الشامي|Al Shami
061|song:aashanak:singer|siilawy|من المطرب صاحب أغنية «عشانك»؟|Which singer performs Aashanak?|سيلاوي|Siilawy
062|song:wbtir:singer|wbtir|من غنّى «وبطير»؟|Who sings W Btir?|زياد برجي|Ziad Bourji
063|song:howehelhob:singer|howeh|من غنّى «هو الحب»؟|Who sings Howeh El Hob?|أدهم نابلسي|Adham Nabulsi
064|artist:fairuz:nickname|fairuznickname|أي مطربة لبنانية تُعرف بلقب «سفيرتنا إلى النجوم»؟|Which Lebanese singer is known as Our Ambassador to the Stars?|فيروز|Fairuz
065|artist:dhaferyoussef:country|dhaferbio|من أي بلد عربي ينتمي الموسيقي ظافر يوسف؟|Which Arab country is musician Dhafer Youssef from?|تونس|Tunisia
066|song:cestlavie:singer|cestlavie|من المطرب الجزائري صاحب أغنية «سي لا في»؟|Which Algerian singer performs Cest La Vie?|الشاب خالد|Khaled
067|song:issamhasni:tribute|issam|لأي مطرب راي جزائري قدّم الرابر عصام تحية في أغنيته «حسني»؟|Which Algerian rai singer does rapper ISSAM honor in Hasni?|الشاب حسني|Cheb Hasni
068|song:tellementnbrick:singer|faudel|من مطرب الراي صاحب أغنية «تلمون نبريك»؟|Which rai singer performs Tellement Nbrick?|الشاب فضيل|Faudel`;
const medium=`125|concert:soleils:thirdsinger|soleils|من شارك الشاب خالد ورشيد طه الغناء في حفل «1، 2، 3 شموس» عام 1998؟|Who sang alongside Khaled and Rachid Taha in the 1998 1 2 3 Soleils concert?|الشاب فضيل|Faudel
126|artist:issam:debutalbum|issam|ما اسم أول ألبوم استوديو للرابر المغربي عصام؟|What is Moroccan rapper ISSAM's debut studio album called?|كريستال|Crystal
127|artist:faudel:debutalbum|faudel|ما اسم أول ألبوم للشاب فضيل؟|What is Faudel's debut album called?|بيضاء|Baida
128|album:rita:dedication|rita|لذكرى أي شاعر فلسطيني أهدى أنور براهم ألبوم «عيون ريتا المذهلة»؟|To which Palestinian poet's memory did Anouar Brahem dedicate The Astounding Eyes Of Rita?|محمود درويش|Mahmoud Darwish
129|festival:lebanesenights:firstyear|baalbeknights|في أي عام انطلقت «الليالي اللبنانية» في مهرجانات بعلبك؟|In which year did the Lebanese Nights begin at the Baalbeck Festival?|1957|1957
130|festival:baalbek:foundation|baalbekhistory|في أي عام تأسّس مهرجان بعلبك الدولي؟|In which year was the Baalbeck International Festival founded?|1956|1956
131|album:carte:doucefrance|carte|على أي ألبوم قدّمت فرقة «كارت دو سيجور» نسختها من «دوس فرانس»؟|On which album did Carte de Sejour release its version of Douce France?|اثنان ونصف|2 et demi
132|album:birdsrequiem:releaseyear|birds|في أي عام صدر ألبوم ظافر يوسف «قدّاس الطيور»؟|In which year was Dhafer Youssef's Birds Requiem released?|2013|2013
133|tradition:gnawa:castanetsterm|gnawaterms|ما اسم الصنوج المعدنية التي تُعزف في موسيقى كناوة؟|What are the metallic castanets played in Gnawa music called?|القراقب|Qraqeb
134|tradition:gnawa:leaderterm|gnawaterms|ما اللقب التقليدي الذي يُطلق على الموسيقي الذي يقود فرقة كناوة؟|What traditional title is given to the musician who leads a Gnawa ensemble?|المعلّم|Maallem
135|album:lepas:originalreleaseyear|lepas|في أي عام صدر «خطوة القط الأسود» لأنور براهم للمرة الأولى، قبل إعادة إصداره عام 2019؟|In which year was Anouar Brahem's Le pas du chat noir originally released, before its 2019 reissue?|2002|2002
136|film:100arabica:khaledcostar|khaledbio|أي مطرب راي شارك الشاب خالد بطولة فيلم «100% عربي»؟|Which rai singer starred alongside Khaled in the film 100% Arabica?|الشاب مامي|Cheb Mami`;
const hard=`193|album:rita:bassclarinetist|rita|من عازف الباس كلارينيت في ألبوم أنور براهم «عيون ريتا المذهلة»؟|Who plays bass clarinet on Anouar Brahem's The Astounding Eyes Of Rita?|كلاوس غيزينغ|Klaus Gesing
194|album:rita:percussionist|rita|من عزف الدربوكة والبندير في ألبوم أنور براهم «عيون ريتا المذهلة»؟|Who plays darbouka and bendir on Anouar Brahem's The Astounding Eyes Of Rita?|خالد ياسين|Khaled Yassine
195|festival:baalbek:resumptionyear|baalbekhistory|في أي عام استأنف مهرجان بعلبك نشاطه بعد توقفه طوال فترة 1975–1996؟|In which year did the Baalbeck Festival resume after its suspension throughout 1975–1996?|1997|1997
196|concert:fairuz1957:openingsong|fairuzopening|بأي أغنية افتتحت فيروز احتفالية «الليالي اللبنانية» في بعلبك عام 1957؟|With which song did Fairuz open the 1957 Lebanese Nights celebration at Baalbeck?|لبنان يا أخضر حلو|Lebnan Ya Akhdar Helou
197|concert:soleils:venue|soleils|في أي قاعة باريسية أُقيم حفل «1، 2، 3 شموس» عام 1998؟|At which Paris venue was the 1998 1 2 3 Soleils concert held?|بيرسي|Bercy
198|album:rhorhomanie:producer|carte|من أنتج ألبوم «روروماني» لفرقة كارت دو سيجور؟|Who produced Carte de Sejour's Rhorhomanie?|ستيف هيلاج|Steve Hillage
199|album:2etdemi:producer|carte|من أنتج ألبوم «اثنان ونصف» لفرقة كارت دو سيجور؟|Who produced Carte de Sejour's 2 et demi?|نيك باتريك|Nick Patrick
200|artist:issam:collective|issam|ما اسم التجمّع الثقافي المقيم في باريس الذي شارك فيه الرابر عصام؟|What is the Paris-based cultural collective in which rapper ISSAM participated?|نار|Naar
201|album:birdsrequiem:clarinetist|birds|من عازف الكلارينيت التركي في ألبوم ظافر يوسف «قدّاس الطيور»؟|Which Turkish clarinetist plays on Dhafer Youssef's Birds Requiem?|حسنو شنلنديريجي|Husnu Senlendirici
202|album:lepas:pianist|lepas|من عزف البيانو في ألبوم أنور براهم «خطوة القط الأسود»؟|Who plays piano on Anouar Brahem's Le pas du chat noir?|فرانسوا كوتورييه|Francois Couturier
203|album:lepas:accordionist|lepas|من عزف الأكورديون في ألبوم أنور براهم «خطوة القط الأسود»؟|Who plays accordion on Anouar Brahem's Le pas du chat noir?|جان لوي ماتينييه|Jean-Louis Matinier
204|artist:fairuz:nicknamecoiner|fairuznickname|من الشاعر الذي أطلق على فيروز لقب «سفيرتنا إلى النجوم»؟|Which poet gave Fairuz the title Our Ambassador to the Stars?|سعيد عقل|Said Akl`;
for(const [tier,rows]of Object.entries({easy,medium,hard}))fs.appendFileSync(`content/arabic_music/${tier}.psv`,rows+'\n');
console.log('Added 35 researched drafts; review required.');
