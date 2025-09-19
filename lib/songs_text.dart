import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// Dummy song data
final List<Map<String, String>> songs = [
  {"title": "1.தேடு கண்டுபிடி",
    "lyrics": "தேடு கண்டுபிடி சத்தியத்தை\n தொலைந்த வெள்ளிக்காசு ஆட்டைப்போல\n\n தேடிடு தேடிடு தேடு கண்டுபிடி - 2\n\n புது மனதோடு தேடிடுவாய்\n அதிகாலை ஜெபத்தில் தேடிடுவாய் - 2\n விடுதலையாக்கும் சத்திய வார்த்தையினாலே தேடிடுவாய் - 2\n\n தேடிடு தேடிடு தேடு கண்டுபிடி - 2\n\n உண்மையாய் ஒழுக்கமாய் தேடிடுவாய்\n நற்செயல்களினால் தேடிடுவாய்\n பக்தியாய் கவனமாய்த் தேடி\n இராஜாக்கள் முன்பாக நின்றிடுவாய் - 2\n\n நம்பிக்கையாய் நீ தேடிடு நீதான் பாக்கியவான்\n தாழ்மையாய் நீ தேடிடு உன்னை உயர்த்திடுவார்\n பொறுமையாய் நீ தேடிடு ஆத்துமாவை காத்துக்கொள்வாய்\n நம்பிக்கையாய் தாழ்மையாய் பொறுமையாய் தேடிடுவாய்",
    "youtubeUrl": "https://www.youtube.com/watch?v=U7S8Dy5_f5Q",},
  {"title": "2.வீட்டை விட்டு ஓடி",
    "lyrics": "வீட்டை விட்டு ஓடிப் போனான் இளைய மகன்\n உண்மை அன்பை உதறிச் சென்றான் நண்பருடன் - 2\n\n ஜாலி ஜாலி ஜாலி\n காலி பணமும் காலி\n\n துட்டும் போயிட்டு மனசு கெட்டும் போயிட்டு\n இதயம் நொறுங்கிட்டு அது அன்பைத் தேடிட்டு - 2\n அப்பாவின் கரங்கள் மகனை உயர்த்திற்று - 2\n லாலா ஆஹா லாலா - 2\n\n தேடிடுவோம் புதிய மனதோடு வாழ்வை\n பெற்றிடுவோம் மகிழ்ச்சியோடு ஹேய் - 2\n\n ஜிம் ஜிம்மா ஹே ஹே ஜிம் ஜிம்மா\n ஜிம் ஜிம்மா ஓஹோ ஜிம் ஜிம்மா - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=RyfvkVCDtTY",},
  {"title": "3.டு டூ டு லாலாலா",
    "lyrics": "டு டூ டு லாலாலா டு டூ டு லாலாலா\n டு டூ டு லாலாலா டு டூ டு\n\n தேடு தேடு புதிய மனசோடு\n பாடு பாடு ஆர்ப்பரிப்போடு - 2\n\n டு டூ டு லாலாலா டு டூ டு லாலாலா\n டு டூ டு லாலாலா டு டூ டு\n\n சத்தியத்தைக் கொண்டு\n நித்தியத்தைக் கண்டு - 2\n\n சந்தோஷமாய் ஆடு நீ\n சந்தோஷமாய் ஆடு\n\n டு டூ டு லாலாலா டு டூ டு லாலாலா\n டு டூ டு லாலாலா டு டூ டு\n\n தேடு தேடு புதிய மனசோடு\n பாடு பாடு ஆர்ப்பரிப்போடு - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=gVZNMgnOfpg",},
  {"title": "4.சொப்பனத்தைக் கண்ட ராஜாவுக்கு",
    "lyrics": "சொப்பனத்தைக் கண்ட ராஜாவுக்கு\n தூக்கமெல்லாம் போயே போச்சு - 2\n\n சொப்பனத்த சொல்லாத ஞானிகளுக்கு\n உயிரை எடுக்க உத்தரவாச்சு - 2\n\n ஐயோ ஐயோ ஐய்யய்யோ - 2\n\n ஞானியான தானியேல் அதைத் தடுத்தார்\n Friendsoட சேர்ந்து ஜெபம் செய்தார் - 2\n\n சொப்பனத்தை சொல்ல மன்னன் மனம் மகிழ - 2\n தானியேலும் நண்பர்களும் உயர்த்தப்பட்டாரே - 2\n\n ஹேப்பி ஹேப்பி ஹேப்பிதான் - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=D6OmTz_GuOo",},
  {"title": "5.குக்கூ குக்கூ",
    "lyrics": "குக்கூ குக்கூ குக்கூ குக்கூ - 2\n ஜில் ஜில் ஜில் ஜில் ஜில் ஜில் ஜில் ஜில்\n குக்கூ குக்கூ குக்கூ குக்கூ - 2\n\n ஜில் ஜில் ஜில் ஜில் குயில் கூவும் நேரம்\n அதிகாலை கர்த்தரைத் தேடும் நேரம் - 2\n\n தானியேலும் தினம் ஜெபம் செய்தான்\n வாழ்வினிலே ஜெயத்தைப் பெற்றுக் கொண்டான் - 2\n\n நீயும் ஜெபி தினமும் நீயும் ஜெபி - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=ZhSYXvLGZgM",},
  {"title": "6.தனன்னன்னானே தனன்னன்னானே",
    "lyrics": "தனன்னன்னானே தனன்னன்னானே\n தனன்னன்னானே னா - 2\n\n சத்திய வார்த்தையினால் தேடு\n தீமைகளை வென்றிடலாம் பாடு - 2\n\n நீயும் தேடிடு நீயும் வென்றிடு\n வேதத்தைத் தினமும் படித்திடு - 2\n\n எஸ்றா வேதத்தைத் திறந்திட\n ஜனங்கள் ஆமென் என்றிட - 2\n\n மனம் திரும்பினர் ஜெபம் செய்தனர் விடுதலை அடைந்தனர் - 2\n\n நீயும் தேடிடு நீயும் வென்றிடு வேதத்தை என்றும் படித்திடு - 2\n\n தனன்னன்னானே தனன்னன்னானே\n தனன்னன்னானே னா - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=QYDFifAzbZk",},
  {"title": "7.டும் டும் டுடு டும்",
    "lyrics": "டும் டும் டுடு டும் டும் டுடு டும் டும் டும் டும் டுடு டும்\n டம் டம் டட டம் டம் டட டம் டம் டம் டம் டட டட டம் - 2\n\n வேதபாரகன் எஸ்றா வேதத்தில் பிரியமாய் இருந்தான் - 2\n வேதத்தைத் தேடவும் வேதத்தை ஆராயவும்\n பக்குவமாயிருந்தான் இஸ்ரவேலை பக்குவப்படுத்தியிருந்தான்\n பக்குவமாயிருந்தான் So ராஜாவிடம் தயவு பெற்றான்\n\n தம்பி தங்கையே தேடு சத்தியத்தை நீயும் தேடு - 2\n சத்தியத்தை படிச்சுக்கோ சத்தியத்தை பிடிச்சுக்கோ\n என்றென்றும் வாழ்ந்திடுவாய்\n நீயும் இயேசு போல் வாழ்ந்திடுவாய்\n\n என்றென்றும் வாழ்ந்திடுவாய் நீயும்\n இயேசுவுக்காய் வாழ்ந்திடுவாய்\n\n டும் டும் டுடு டும் டும் டுடு டும் டும் டும் டும் டுடு டும் - ஹேய்\n டம் டம் டட டம் டம் டட டம் டம் டம் டம் டட டம் - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=ftGqMboEDDU",},
  {"title": "8.லாலலா லாலலா",
    "lyrics": "லாலலா லாலலா\n லாலலா லாலலா\n லாலலா லாலலா லாலலா\n லாலலா லாலலா லால்லா\n\n யோசேப்பு தேடினான் உண்மையாய் தேடினான்\n உண்மையுள்ள மனுஷன் ஆசீர்வாதம் பெறுவான்\n தம்பி தங்காய் இயேசுவையே நீயும் தேடிடு - 2\n\n எகிப்துக்கு சென்றான் சொந்த பந்தம் இல்லை\n ஆனாலும் யோசேப்பு உண்மையாய் இருந்தான்\n\n அடிமையாய் போனவன் அதிகாரியாயினான்\n பரிபூரணமான ஆசீர்வாதம் பெற்றான்\n\n னன்னனான னானா\n னன்னனான னானா",
    "youtubeUrl": "https://www.youtube.com/watch?v=W18AWuDUJsA",},
  {"title": "9.Ready, on your mark, get set go!",
    "lyrics": "Ready, on your mark, get set go!\n\n ஓடிட உனக்கொரு ஓட்டம்\n உலகத்தில் உனக்கு உண்டு - 2\n\n உண்மையாக ஓடிடு இயேசுவை நீ தேடிடு\n செல்லமான சிறுவன் அடிமையான வாலிபன்\n உண்மையாக தேடினான் அதிபதியாய் உயர்ந்தான்\n\n உண்மையாக நீயும் தேடிடு யோசேப்பு போல உயர்வாய் - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=bkvlaOLXbTg",},
  {"title": "10.கொக்கரக்கோ கொக்கரக்கோ",
    "lyrics": "கொக்கரக்கோ கொக்கரக்கோ - 2\n\n ஒழுக்கமாக வாழ்ந்திடு ஓசன்னா பாடிடு\n அனுதினம் நீ ஜெபித்திடு கருத்தாய் வேதம் படித்திடு\n\n கொக்கரக்கோ கொக்கரக்கோ - 2\n\n சாட்சியாய் நீ வாழ்ந்திடு\n இயேசுவை நீ கண்டிடு - 2\n\n கொக்கரக்கோ கொக்கரக்கோ - 2\n\n இதுபோல வாழ்ந்தாரே கொர்நேலியு\n அதனால் அதிசயத்தைக் கண்டாரே - 2\n\n சத்தியத்தை அறிந்தாரே\n சந்தோஷமாய் வாழ்ந்தாரே - 2\n\n கொக்கரக்கோ கொக்கரக்கோ - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=e8IyTF804J8",},
  {"title": "11.ரபபபபபபப்பா ரபபபபபபப்பா",
    "lyrics": "ரபபபபபபப்பா ரபபபபபபப்பா\n ரபபபபபபப்பா ரபபபபபபப்பா\n\n ஒழுக்கமாய் தேடு ஹேய்\n ஒவ்வொரு நாளும் தேடு - 2\n\n நீ புத்தியோடு தேடு நித்தமும் தேடு\n தேடு தேடு தேடு - 2\n\n சத்தியத்தை நீயும் தேடு\n\n ரபபபபபபப்பா ரபபபபபபப்பா\n ரபபபபபபப்பா ரபபபபபபப்பா",
    "youtubeUrl": "https://www.youtube.com/watch?v=GpbV7zZdAKs",},
  {"title": "12.ஹய்யா ஹே ஹய்யா",
    "lyrics": "ஹய்யா ஹே ஹய்யா\n ஹேப்பி ஹேப்பி ஹேப்பி தான்\n ஹய்யா ஹே ஹய்யா\n ஜாலி ஜாலி ஜாலி தான் - 2\n\n Beauty பட்டாம் பூச்சி பூக்களைப் பெருகச் செய்யிறியே\n Blacky காகம் அண்ணா குயிலுக்குக் கூடு கொடுக்கிறியே - 2\n\n உங்களைப் போல நானும் நன்மை செய்யணும்\n தங்கப்பிள்ளை என்று Jesus சொல்லணும் - 2\n\n ஹேப்பிதான் ஜாலிதான்\n எனக்கு எனக்குதான் - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=5rEzwnr4k24",},
  {"title": "13.டிப்டாப் டிப்டாப்",
    "lyrics": "டிப்டாப் டிப்டாப் டிப்டாப் டிப்டாப்\n டிப்டாப் டிப்டாப் டிப்டாப் டிப்டாப்  டிப்டாப்  டிப்டாப்\n டிப்டாப் டிப்டாப் டிப்டாப் டிப்டாப் - 2\n\n Over ஆக மேக்கப் போட்டு Face அ காட்டுற தங்காய்\n சண்டைய போட்டு மண்டைய ஒடச்சி சேட்டப் பண்ணுற தம்பி - 2\n\n சின்ன சின்ன உதவிகள் செய்யும் நல்ல அன்பு\n உந்தன் வாழ்வை அழகாக ஜொலிக்க வைக்கும் பண்பு - 2\n\n தொற்காள் அக்கா போல நீயும் வாழ்ந்திடு\n நற்கிரியை என்னும் ஒளியாய் மாறிடு - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=X5HwSFHtb4s",},
  {"title": "14.ஹேய் பிடி பிடி பிடி",
    "lyrics": "ஹேய் பிடி பிடி பிடி பிடி பிடி பிடி\n டக்சிக் டக்சிக் டக்சிக் டக்சிக்\n\n தர்சு பட்டண சவுல் ஜனத்தை படுத்தினானே பாடு\n பக்தியுள்ள பவுலாய் மாற இயேசுவை தினமும் தேடு - 2\n\n தெரிந்து கொண்ட பாத்திரம் நீதான் தாளம் போடு போடு - 2\n\n சவுலா நீ No No No\n பவுலா நீ Yes Yes Yes\n\n பாரு பாரு தம்பி தங்காய் பவுலைக் கொஞ்சம் பாரு\n பக்தியோடே வாழு அதுவே என்றும் ஜோரு\n பக்தியோடே வாழு அதுவே படு ஜோரு\n டக்சிக் டக்சிக் டக்சிக் டக்சிக் டக்சிக் டக்சிக் டக்",
    "youtubeUrl": "https://www.youtube.com/watch?v=9wRHVHrkssg",},
  {"title": "15.தேடு தேடு ஆண்டவரைத் தேடு",
    "lyrics": "தேடு தேடு ஆண்டவரைத் தேடு\n நாடு நாடு பக்தியாய் நாடு\n ஓடு ஓடு பாவத்தை விட்டோடு\n பாடு பாடு மகிழ்ந்து பாடு - 2\n\nஇயேசுவே நித்தியம் அவரே வாழ்வின் சத்தியம் - 4\n\n தேடு தேடு ஆண்டவரைத் தேடு\n நாடு நாடு பக்தியாய் நாடு\n ஓடு ஓடு பாவத்தை விட்டோடு\n பாடு பாடு மகிழ்ந்து பாடு",
    "youtubeUrl": "https://www.youtube.com/watch?v=4n_oZLLFDsw",},
  {"title": "16.புத்தி உள்ள 5 அக்கா",
    "lyrics": "புத்தி உள்ள 5 அக்கா புத்தி இல்லா 5 அக்கா\n போனாங்க போனாங்க Marriage-க்கு போனாங்க\n போனாங்க போனாங்க படுசோக்கா தான் போனாங்க - 2\n\n சூப்பரா எரிஞ்சுது பாரு 5 விளக்கு\n அணஞ்சு அணஞ்சு போச்சது மத்த 5 விளக்கு - 2\n\n எண்ணெய் இல்லாமல் விளக்கு எரியுமா - 2\n\n இயேசப்பா உன்னில் இருந்தால் தான்\n உன் வாழ்க்கை பிரகாசிக்கும் - 2\n\n உன் வாழ்க்கை பிரகாசிக்கும்\n\n லல்லலலா லாலாலா லல்லலலா லாலாலா\n லல்லலலா லல்லலலா லல்லாலல்லல்லா - 2\n லல்லலலா லல்லலலா லால்லால்லா\n",
    "youtubeUrl": "https://www.youtube.com/watch?v=8WtlnQJGUAs",},
  {"title": "17.தந்தனத்தானே ஒய்யாரே",
    "lyrics": "தந்தனத்தானே ஒய்யாரே தந்தனத்தானே -2\n\n கவனம் கவனம் உன் வாழ்வில் கவனம் கவனம்\n தேடு தேடு தேவனையே தேடு தேடு\n நாடு நாடு வசனத்தை நாடு நாடு - 2\n\n அசதியாய் இராமல் ஜாக்கிரதையாய் நாடு\n அசதியாய் இராமல் ஜாக்கிரதையாய் தேடு\n நிச்சயம் நிச்சயம் பரலோகமே - 2\n\n தந்தனத்தானே ஒய்யாரே தந்தனத்தானே - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=_zXJ5wcb8Ew",},
  {"title": "18.தேடு தினமும் தேடு",
    "lyrics": "தேடு தினமும் தேடு தம்பி\n தேடு நம்பிக்கையாய் தேடு\n\n தேடு தினமும் தேடு தங்கை\n தேடு நம்பிக்கையாய் தேடு\n\n யோபு போல நம்பிக்கையாய் தேடு\n இரட்டிப்பாய் பெற்றுக்கொள்வாயே\n\n இயேசுவையே நம்புகிற மனுஷன்\n பாக்கியவான் தெரியுமா\n\n நீயும் நம்பித் தேடு தினமும் தேடு\n இயேசுவை மட்டுமே தேடு - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=_T8IcqLwAJM",},
  {"title": "19.என்னால முடியல எதுவும் தெரியல",
    "lyrics": "என்னால முடியல எதுவும் தெரியல - 2\n பயப்படாதே திகைத்திடாதே தம்பி தங்காய் - 2\n\n யோசபாத் ராஜாவும் யூத ஜனங்களும்\n தரைமட்டும் தாழ்த்தி ஜெபித்ததினாலே - 2\n\n எதிரிகளை கர்த்தர் முறியடித்தார் - 2\n\n கர்த்தருக்கு முன்பாக உன்னைத் தாழ்த்திடு\n உண்மையாய் ஜெபித்து உயர்வை பெற்றிடு\n நீயும் உயர்வை பெற்றிடு\n\n ஆஹாஹா ஓஹோஹோ லா லா ல லா\n ஆஹாஹா ஓஹோஹோ ஹோ",
    "youtubeUrl": "https://www.youtube.com/watch?v=-1gU8hB2aQ0",},
  {"title": "20.டும் டும் டுடுடு டும் டும் டுடுடு",
    "lyrics": "டும் டும் டுடுடு டும் டும் டுடுடு\n டும் டும் டும் டும் டும் - 2\n\n பொறுமை வேண்டுமே\n பொறுமை வேண்டுமே\n அன்புத் தம்பி தங்காய் - 2\n\n பொறுமையாகவே நீ தேடு\n சிமியோன் தாத்தா போல் நீ தேடு\n\n இயேசுவைக் காண்பாய் இயேசுவைக் காண்பாய் - 2\n\n காத்திருந்து பாரு தினம் பொறுமையாகத் தேடு - 2",
    "youtubeUrl": "https://www.youtube.com/watch?v=T-yt2Mas-xY",},
];

// StatefulWidget for Songs List
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Songs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SongsList(),
    );
  }
}

// StatefulWidget for Songs List
class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('பாடல்கள்'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index]["title"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongDetail(
                    title: songs[index]["title"]!,
                    lyrics: songs[index]["lyrics"]!,
                    youtubeUrl: songs[index]["youtubeUrl"]!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// StatefulWidget for Song Detail
class SongDetail extends StatefulWidget {
  final String title;
  final String lyrics;
  final String youtubeUrl;

  const SongDetail({
    required this.title,
    required this.lyrics,
    required this.youtubeUrl,
    super.key,
  });

  @override
  _SongDetailState createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController _controller;
  bool _isVideoValid = true;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      _isVideoValid = false;
      debugPrint('Invalid YouTube URL: ${widget.youtubeUrl}');
    }
  }

  @override
  void dispose() {
    if (_isVideoValid) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Ensures content is scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lyrics,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              if (_isVideoValid)
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  onReady: () {
                    // Optionally perform actions when the player is ready
                  },
                  onEnded: (metadata) {
                    // Optionally perform actions when the video ends
                  },
                )
              else
                const Text(
                  'Video not available.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),

              Align(
                alignment: Alignment.bottomCenter,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Text(
                    '© MLCC Youth',
                    style: GoogleFonts.hammersmithOne(
                      textStyle: TextStyle(
                        // 4% of screen width as the default font size
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}