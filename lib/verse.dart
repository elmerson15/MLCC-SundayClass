import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class VersePage extends StatefulWidget {
  const VersePage({super.key});
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  // List of months, titles, and verses
  final List<Map<String, String>> verses = [
    {'month': 'June 2024', 'title': 'தேடு கண்டுபிடி-சத்தியத்தை', 'verse': 'மத்தேயு 7:7 - தேடுங்கள், அப்பொழுது கண்டடைவீர்கள்.'},
    {'month': 'July 2024', 'title': 'புதுமனதோடு தேடு!', 'verse': 'எசேக்கியேல் 36:26 - ...நவமான இருதயத்தை ...உங்களுக்குக் கொடுப்பேன்.'},
    {'month': 'August 2024', 'title': 'ஜெபத்தினால் தேடு!', 'verse': 'நீதிமொழிகள் 8:17 - ...அதிகாலையில் என்னைத் தேடுகிறவர்கள் என்னைக் கண்டடைவார்கள்.'},
    {'month': 'September 2024', 'title': 'வார்த்தையினால் தேடு!', 'verse': 'யோவான் 8:32 - சத்தியத்தையும் அறிவீர்கள், சத்தியம் உங்களை விடுதலையாக்கும் என்றார்.'},
    {'month': 'October 2024', 'title': 'உண்மையாய் தேடு!', 'verse': 'நீதிமொழிகள் 28:20 - உண்மையுள்ள மனுஷன் பரிபூரண ஆசீர்வாதங்களைப் பெறுவான்;'},
    {'month': 'November 2024', 'title': 'ஒழுக்கமாய் தேடு!', 'verse': '1 கொரிந்தியர் 14:40 - சகலமும் நல்லொழுக்கமாயும் கிரமமாயும் செய்யப்படக்கடவது.'},
    {'month': 'December 2024', 'title': 'நற்செயலினால் தேடு!', 'verse': 'நீதிமொழிகள் 3:27 - நன்மைசெய்யும்படி யிருக்கும்போது, உனக்குத் அதைச் திராணி செய்யத் தக்கவர்களுக்குச் செய்யாமல் இராதே.'},
    {'month': 'January 2025', 'title': 'பக்தியாய் தேடு!', 'verse': 'சங்கீதம் 4:3 - பக்தியுள்ளவனைக் கர்த்தர் தமக்காகத் தெரிந்துகொண்டார் ...'},
    {'month': 'February 2025', 'title': 'கவனமாய் தேடு!', 'verse': 'நீதிமொழிகள் 22:29 - தன் வேலையில் ஜாக்கிரதையாய் இருக்கிறவனை நீ கண்டால், அவன் நீசருக்கு முன்பாக நில்லாமல், ராஜாக்களுக்கு முன்பாக நிற்பான்.'},
    {'month': 'March 2025', 'title': 'நம்பிக்கையாய் தேடு!', 'verse': 'எரேமியா 17:7 - ...கர்த்தரைத் தன் நம்பிக்கையாகக் கொண்டிருக்கிற மனுஷன் பாக்கியவான்.'},
    {'month': 'April 2025', 'title': 'தாழ்மையாய் தேடு!', 'verse': 'யாக்கோபு 4:10 -  கர்த்தருக்கு முன்பாகத் தாழ்மைப்படுங்கள், அப்பொழுது அவர் உங்களை உயர்த்துவார்.'},
    {'month': 'May 2025', 'title': 'பொறுமையாய் தேடு!', 'verse': 'லூக்கா 21:19 - உங்கள் பொறுமையினால் உங்கள் ஆத்துமாக்களைக் காத்துக்கொள்ளுங்கள்.'}
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Force textScaleFactor to 1.0
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Monthly Verse'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: verses.length + 1,  // Extra item for the copyright text
          itemBuilder: (context, index) {
            if (index < verses.length) {
              final verseData = verses[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          verseData['month']!,
                          style: TextStyle(
                            fontSize: 20,  // Fixed font size
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          verseData['title']!,
                          style: TextStyle(
                            fontSize: 18,  // Fixed font size
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple[800],  // Replacing yellow
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          verseData['verse']!,
                          style: const TextStyle(
                            fontSize: 16,  // Fixed font size
                            color: Colors.black87,
                          ),
                          maxLines: 5,  // Ensuring the verse is visible
                          overflow: TextOverflow.ellipsis,  // Adding ellipsis for overflow
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '© MLCC Youth',
                    style: GoogleFonts.hammersmithOne(
                      textStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
