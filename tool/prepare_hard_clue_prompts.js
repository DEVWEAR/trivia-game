const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const text = fs.readFileSync(path.join(root,'lib/data/questions/two_pics_questions_069_102.dart'),'utf8');
const re = /_p600\('two_pics_(\d{3})','([^']*)','([^']*)','([^']*)','([^']*)'\)/g;
const detail = {
  'heart model':'a clearly recognizable red anatomical human heart classroom teaching model, clean plastic, isolated on a light grey tabletop; no real organ or gore',
  'stone rock':'one solid irregular grey stone rock with natural rough texture, centered on a plain sand-colored tabletop',
  'sewing needle':'one large clearly visible silver sewing needle lying diagonally on plain beige linen, its eye unmistakable; no thread or pins',
  'haystack':'a traditional large conical haystack outdoors in a harvested rural field, visibly composed of golden straw; no needle',
  'calm sea':'an exceptionally calm still blue sea, smooth glassy surface and level horizon under pale clear sky; no boats or storm',
  'storm clouds':'dark dramatic thunderstorm clouds gathering over a sea horizon, distinctly stormy weather with a distant lightning flash',
  'clock':'an unbranded analog clock with two hands and twelve simple hour ticks but no numerals or lettering, clearly recognizable on a plain tabletop',
  'gold bars':'a small stack of realistic gleaming yellow-gold bullion bars, smooth unmarked surfaces on a neutral tabletop; no stamps or text',
  'blood drop':'one neat glossy dark-red blood-like droplet on a clean white medical glass surface, non-graphic, no wound, injury, needle or body',
  'ice':'several translucent ice cubes with frost and tiny droplets, close-up on a cool blue surface; no blood',
  'person thinking':'an original fictional adult in modest casual clothing, thoughtful expression, one finger gently touching the temple, eyes focused upward; no text or thought bubble',
  'goldfish':'one bright orange goldfish swimming in clear water, recognizable fins and scales, uncluttered dark aquatic background',
  'black box':'one closed plain matte-black rectangular box, unmistakably BLACK, on a light grey tabletop; no writing, aircraft, orange recorder, lid contents or electronics',
  'airplane':'a plain unbranded white passenger airplane flying in blue sky, whole aircraft visible, no airline logo, letters or numbers',
  'rescue rope':'a sturdy rescue rope coiled beside water, with one clearly visible loop and knot; no life jacket, boat or people',
  'life jacket':'one recognizable orange foam life jacket, open armholes and front buckles visible, centered on a neutral dock surface; no writing or person',
  'mouth speaking':'close-up lower face of an original fictional adult speaking with lips naturally parted, only one face, modest framing; no text, sound glyphs or microphone',
  'padlock login':'an original clean laptop login interface showing only a large closed padlock symbol and two blank input fields, no letters, logos or recognizable operating-system design',
  'metal key':'one antique-style metal key with a round bow and clearly cut teeth, full key visible diagonally on a neutral tabletop',
  'finish line winner':'one original fictional modestly dressed runner crossing a plain finish ribbon with raised arms on an athletics track, unmistakable winning finish, no text, logos or bib numbers',
  'ladder':'one freestanding wooden ladder with clearly visible evenly spaced rungs, entirely visible against a plain workshop wall',
  'success stairs':'a sunlit ascending staircase leading to a bright top platform with one small unmarked trophy at the top, visually suggesting achievement; no person, ladder or text',
  'road':'a clear paved road extending toward the horizon through open land, unobstructed asphalt road, no road signs or vehicles',
  'road barrier':'a paved road ending at a closed red-and-white striped physical barrier with a solid wall beyond, clear dead end; no text or road signs',
  'open doorway':'one open doorway with inviting warm daylight beyond it, whole frame visible, no person, key or lettering',
  'gold bar':'one gleaming yellow-gold bullion bar with smooth completely unmarked surfaces, isolated on a dark neutral tabletop',
  'face side profile':'an original fictional adult human face photographed in a clean exact side profile, ear nose chin clearly visible, neutral background, soft light, modest portrait; no text',
  'dark shadow':'a sharply defined deep dark shadow cast by a single ordinary object across a bright plain wall, stark light-dark contrast, shadow is the obvious subject',
  'black dot':'one small solid round BLACK DOT, centered on a clean white card photographed on a white tabletop, no other marks or text; it should remain easily visible in a game thumbnail',
  'sharp road turn':'an aerial view of a clearly sharp hairpin bend in a paved mountain road, curve is unmistakable, no cars or signs',
  'broken chain':'one heavy metal chain with a single snapped open link clearly separated at its center, close-up on a plain dark tabletop',
  'calendar routine':'an unbranded paper weekly planner showing a repeated daily schedule using identical small check marks in a regular grid, absolutely no letters, numbers or legible text',
  'person outside box':'one original fictional modestly dressed adult standing unmistakably OUTSIDE and beside a large open empty cardboard box on a plain studio floor; both person and box entirely visible, no text',
  'cardboard box':'one plain open brown cardboard box, centered and empty, visible corrugated texture, no labels, packing tape lettering or people',
  'human head':'a clearly recognizable whole human head and neck portrait of an original fictional adult facing the camera, neutral expression, plain background, modest crop, no text',
  'mountain peak':'one distinct rugged mountain summit rising prominently above surrounding ridges, close enough that the pointed highest peak is obvious, original natural landscape, no text',
  'ship sea':'one large traditional wooden sailing ship at sea, whole hull and sails visible, realistic water, no lettering or flags',
  'camel desert':'one dromedary camel standing in golden desert dunes, whole camel and single hump plainly visible, no people, saddle branding or text',
  'ocean waves':'rolling deep-blue ocean waves photographed from shore level, unmistakable open ocean and frothy crests, no surfers or boats',
  'sand dunes':'a sweeping original desert landscape of golden sand dunes with wind-ripple texture, entirely dry, no water, camel or people',
  'old map':'an antique parchment treasure-style map with original fictional coastline shapes and a small plain X marking a spot, no letters, place names, numerals or copied historical map',
  'treasure chest':'one open old wooden treasure chest with gleaming coins and a few gems visibly inside, plain unmarked metal fittings, no people or text',
  'future city':'an original fictional futuristic sustainable city of inventive modern towers and green terraces at dawn, no recognizable famous building, logos, lettering or flying vehicles',
  'gemstones':'a small group of sparkling loose cut gemstones, clearly visible ruby, emerald and sapphire colors, close-up on dark velvet, no crown or text',
  'royal crown':'one original ornate generic royal crown with gold arches and small colored stones, isolated on a plain tabletop, no real royal insignia or text',
  'specimen slide':'one transparent laboratory glass specimen slide with a tiny sample beneath a coverslip, fully visible close-up on a neutral lab bench, no microscope, labels or writing',
  'microscope':'one realistic unbranded optical laboratory microscope, recognizable eyepiece objective lenses and stage, entire instrument centered, no writing',
  'sun ray clouds':'a clearly visible shaft of warm sunlight breaking through dark clouds onto open land, the distinct ray of light is the subject',
  'hopeful horizon':'a luminous golden sunrise appearing over a broad clear horizon after darkness, gentle bright sky and serene original landscape, visual hopeful new dawn, no people or text',
  'planet earth':'a photorealistic original rendering of planet Earth seen from space, familiar blue oceans, recognizable Africa and Arabia, white clouds and dark space, no text or copied space-agency photograph',
  'thermometer heat':'a realistic unbranded glass thermometer with a red liquid column visibly high near its top, minimal unlabeled ticks, warm sunlit background suggesting heat, no numerals, words or degree labels',
  'water spring':'a natural fresh-water spring visibly bubbling out of rock into a clear small stream in a green woodland setting, no steam, faucet, fountain or writing',
  'steaming hot spring':'a natural geothermal hot-spring pool with unmistakable rising steam above warm water surrounded by rocks, original landscape, no bathers or text',
  'concrete wall':'one tall continuous plain grey concrete wall with visible mineral texture, frontal view, no writing, cracks shaped as letters, people or decorations',
  'silence gesture':'an original fictional adult in modest clothing making an unmistakable quiet gesture with one index finger gently placed vertically in front of closed lips, portrait, no text',
  'surfer':'one original fictional modestly dressed surfer in a wetsuit riding a surfboard on water, whole surfer and board visible, balanced stance, no brands or text',
  'ocean wave':'one prominent curling turquoise ocean wave with a clear crest and barrel, no surfer, board, boat or text',
  'athlete jump':'one original fictional modestly dressed athlete captured fully airborne in a powerful standing long jump, clear gap above ground and dynamic upward movement, no logos or text',
  'upward progress':'a photorealistic tabletop arrangement of ascending wooden blocks with one clear plain upward arrow rising above them, unmistakable progress upward, no letters, labels or numbers',
  'iceberg':'one realistic floating iceberg in polar seawater, clearly visible small pointed ice tip above the surface, visible broad ice body at the waterline, no mountain on land or text',
  'owl':'one recognizable owl perched on a branch, round eyes feather detail and ear tufts clearly visible, whole bird centered, no text',
  'city night':'an original generic city skyline after dark, deep night sky and glowing windows, no recognizable copyrighted landmark, moon illustration, lettering or logos',
  'insect':'one clearly recognizable small beetle insect, six legs and antennae visible, macro photograph on a neutral pale leaf, no spider, computer or text',
  'computer error':'one unbranded laptop with an original generic dark computer screen showing a clear large red warning triangle and simple crossed-out function symbol, no text, error codes, logos or recognizable OS interface',
  'spider':'one recognizable small orb-weaver spider, all eight legs visible, macro photograph on a plain leaf, no visible web, no text or exaggerated scary features',
  'spider web':'one clearly recognizable delicate circular orb spider web between branches, fine radial and spiral threads with dew drops, no spider visible, dark soft garden background',
};
const entries=[];
for(const match of text.matchAll(re)){
  const [,number,answerAr,answerEn,left,right]=match;
  for(const [index,cue] of [left,right].entries()){
    if(!detail[cue])throw new Error('No exact prompt for '+cue);
    const id=number+'_'+(index+1);
    const prompt='Use case: photorealistic-natural. Asset: ONE independent original photographic clue for a premium bilingual two-picture guessing game, '+id+'. Subject: '+detail[cue]+'. Single coherent image with an uncluttered composition. Natural textures, realistic lighting, crisp recognizable main subject. Frame for a landscape 4:3 game card, center the essential subject and leave safe margin so it remains legible at thumbnail size. No labels, answer words, watermarks, logos, borders, collage or other clue objects. Create genuinely new original artwork, not imitation of an existing photograph or artist. Depict this subject only; do not reveal the whole phrase.';
    entries.push({id,card:'two_pics_'+number,answerAr,answerEn,cue,prompt,path:'two_pics/'+id+'.png',origin:'Original built-in image generation; no stock photograph copied',review:'pending'});
  }
}
if(entries.length!==68)throw new Error('Expected 68 independent image prompts');
fs.writeFileSync(path.join(root,'content/hard_two_pics_image_prompts.json'),JSON.stringify(entries,null,2)+'\n');
console.log('Prepared 68 exact clue prompts, preserving existing answer text.');
